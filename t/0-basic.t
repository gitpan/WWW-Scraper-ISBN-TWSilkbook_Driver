#!/usr/bin/env perl

use strict;
use Test::More tests => 14;

use_ok('WWW::Scraper::ISBN::TWSilkbook_Driver');

ok($WWW::Scraper::ISBN::TWSilkbook_Driver::VERSION) if $WWW::Scraper::ISBN::TWSilkbook_Driver::VERSION or 1;

use WWW::Scraper::ISBN;
my $scraper = WWW::Scraper::ISBN->new();
isa_ok($scraper,'WWW::Scraper::ISBN');

$scraper->drivers("TWSilkbook");
my $isbn = "9864175351";
my $record = $scraper->search($isbn);

SKIP: {
	skip($record->error."\n", 11) unless($record->found);

	is($record->found, 1);
	is($record->found_in, 'TWSilkbook');

	my $book = $record->book;
	is($book->{'isbn'}, '9864175351');
	is($book->{'title'}, '�Ů������G�}�еL�H�v�������s����');
	is($book->{'author'}, '������B���B��');
	is($book->{'pages'}, '376');
	is($book->{'book_link'}, 'http://www.silkbook.com/content/4th.asp?goods_ser=kk0123360');
	is($book->{'image_link'}, 'http://www.silkbook.com/mall_image/bk/kk0123360.jpg');
	is($book->{'pubdate'}, '2005�~8��5��');
	is($book->{'publisher'}, '�ѤU���');
	is($book->{'price_list'}, '450');
}
