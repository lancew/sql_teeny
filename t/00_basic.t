use strict;
use warnings;

use Test::Most tests => 7, 'die';
use sql_teeny;

dies_ok { sql_teeny::interpolate() } 'expecting to die';

my ($sql, @bind) = sql_teeny::interpolate(
    statement => 'SELECT * FROM rand_table WHERE alpha = ? AND %s ORDER BY id DESC',
    data      => [1, { beta => 2} ],
);

is $sql, 'SELECT * FROM rand_table WHERE alpha = ? AND beta = ? ORDER BY id DESC', 'SQL Statement correct';
is_deeply \@bind, [1,2], 'Bind values correct';

($sql, @bind) = sql_teeny::interpolate(
    statement => 'SELECT * FROM rand_table WHERE alpha = ? AND %s OR %s ORDER BY id DESC',
    data      => [1, { beta => 2 },{ capa => 3 } ],
);

is $sql, 'SELECT * FROM rand_table WHERE alpha = ? AND beta = ? OR capa = ? ORDER BY id DESC', 'SQL Statement correct';
is_deeply \@bind, [1,2,3], 'Bind values correct';


($sql, @bind) = sql_teeny::interpolate(
    statement => 'SELECT * FROM rand_table WHERE alpha = ? AND %s OR %s AND last = ? ORDER BY id DESC',
    data      => [1, { beta => 2 },{ capa => 3 }, 'Test' ],
);

is $sql, 'SELECT * FROM rand_table WHERE alpha = ? AND beta = ? OR capa = ? AND last = ? ORDER BY id DESC', 'SQL Statement correct';
is_deeply \@bind, [1,2,3,'Test'], 'Bind values correct';

done_testing;
