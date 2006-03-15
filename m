From: TuskenTower <tuskentower@gmail.com>
Subject: Update to pmtools/acpidump/acpitbl to add SRAT and SLIT decoding
Date: Wed, 15 Mar 2006 11:33:58 -0500
Message-ID: <741eae780603150833v5137e249y76d524e4f3e01c6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8213_12693154.1142440438102"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.201]:38351 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752134AbWCOQeA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Mar 2006 11:34:00 -0500
Received: by nproxy.gmail.com with SMTP id x30so107706nfb
        for <linux-acpi@vger.kernel.org>; Wed, 15 Mar 2006 08:33:58 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, intel-linux-acpi@linux.intel.com

------=_Part_8213_12693154.1142440438102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

All,
  I updated the script acpitbl (pmtools/acpidump/acpitbl) to decode
the SRAT (Static Resource Allocation Table) and the SLIT (System
Locality distance Information Table) on an ES7000/600.

  I didn't play nice with the current decoding scheme since my
knowledge of using PERL's binary packing routines is limited.  Does
anyone see what changes I could make to keep the added code consistent
with the existing decoding scheme?

thanks,
Amul

------=_Part_8213_12693154.1142440438102
Content-Type: application/octet-stream; name=acpitbl
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ektv8ax5
Content-Disposition: attachment; filename="acpitbl"

#!/usr/bin/perl
#
# acpitbl - ACPI table dumper
#
# Example: ./acpidump -t FACP | ./acpixtract | ./acpitbl
#

($ME = $0) =~ s|.*/||;

%DESCS = &get_descs;

if(@ARGV)
{
    my($file);
    for $file (@ARGV)
    {
	if(open(IN, "$file"))
	{
	    &process(IN, STDOUT);
	    close(IN);
	}
	else
	{
	    print STDERR "$ME: $file: $!\n";
	}
    }
}
else
{
    &process(STDIN, STDOUT);
}

exit(0);

sub
process
{
    local(*IN, *OUT) = @_;

    my($signature) = "";
    my($remaider) = "";

    sysread(IN, $signature, 4);
    if(!defined($DESCS{$signature}))
    {
	print STDERR "$ME: invalid table signature\n";
	return -1;
    }
    
    my($data) = $signature;
    while(1)
    {
	my($d) = "";
	my($s) = sysread(IN, $d, 1024);
	last if($s <= 0);
	$data .= $d;
    }

    $remainder = &show_table(OUT, $DESCS{$signature}, \$data);
    if ( length( $remainder) )
    {
	if ( $signature eq "SLIT" ) { &show_slit ( OUT,\$remainder); }
	if ( $signature eq "SRAT" ) { &show_srat ( OUT,\$remainder); }
    }

    return 0;
}

sub
show_slit
{
    local(*OUT, *data) = @_;

    my($data_length) = length($data) - 8;
    my($loc) = unpack("I", $data);

    print OUT sprintf("Localities:\t0x%x\n", $loc);

    my(@slit_grid) = split ( '', substr( $data, 8, $data_length) );

    for ( my $col = 0; $col < $loc; $col++) { print OUT "\t$col";} # print the columns

    for ( my $row = 0; $row < $#slit_grid; $row+=$loc)
    {
	print OUT "\n" . ($row/$loc) . "\t"; # print the row headings
	for ( my $col = 0; $col < $loc; $col++ )
	{
	    $posn = $row+$col;
	    print OUT ord($slit_grid[$posn]) . "\t"; #ord gets the decimal value of the hex char
	}
    }
     print OUT "\n";
}

sub
show_srat
{
    local(*OUT, *data) = @_;

    my($data_length) = length($data) - 12;
    my($rev,$rsrvd) = unpack("cc", $data);
    my($remainder) = substr( $data, 12, $data_length);

    print OUT sprintf("Table Rev:\t0x%x\n", $rev);
    print OUT sprintf("Reserved:\t0x%x\n", $rsrvd);

    while ( $data_length > 0 )
    {
	my($type,$len) = unpack("cc",$remainder);
	if ( $len == 0 ) { print STDERR "No more data ($len).\n"; break; }

	if ( $type == 0 ) { &show_srat_processor_aff ( substr( $remainder, 0, $len)); }
	if ( $type == 1 ) { &show_srat_memory_aff ( substr( $remainder, 0, $len)); }

	$data_length -= $len; 
	$remainder = substr( $remainder, $len, $data_length);
    }
}

sub
show_srat_processor_aff
{
    my($data) = shift;
    my($type,$len,$prox,$apic,$flags,$lsapic,$rsrv) = unpack("ccccIcc3",$data);
    print OUT "Proc Aff  Domain: $prox\tAPIC: $apic \tFlags: $flags\tLSAPIC: $lsapic\t Reserved: $rsrv\n";
}

sub
show_srat_memory_aff
{
    my($data) = shift;
    my($type,$len,$prox,$rsrv)=unpack("cccc5",$data);
    $data = substr ( $data, 8, $len - 8 );
    my($baseLoByte,$baseHiByte,$lenLoByte,$lenHiByte,$memType,$flags,$rsrv2)=unpack("IIIIIII2",$data);
    print OUT sprintf ("Mem Aff   Domain: %d\tBase: 0x%04x%08x\tLen: 0x%04x%08x\tMem: %d\tFlags: %x\tReserved: %x:%x\n", 
		       $prox, $baseHiByte, $baseLoByte, $lenHiByte, $lenLoByte, $memType, $flags, $rsrv, $rsrv2);

}

sub
show_table
{
    local(*OUT, *desc, *data) = @_;
    my(%size_to_tmpl) =
	("D1"=>"C", "D2"=>"S",  "D4"=>"I",
	 "X1"=>"C", "X2"=>"S",  "X3"=>"a3",
	 "X4"=>"I", "A4"=>"A4", "A6"=>"A6",
	 "A8"=>"A8", "X8"=>"I", "h8"=>"b9"
	 );
    my(%size_to_fmt) =
	("D1"=>"%d", "D2"=>"%d", "D4"=>"%d",
	 "X1"=>"0x%02x", "X2"=>"0x%04x", "X3"=>"0x%06x",
	 "X4"=>"0x%08x", "A4"=>"%s", "A6"=>"%s",
	 "A8"=>"%s", "X8"=>"0x%016x", "h8"=>"%d"
	 );

    my($tmpl) = "";
    my($max_size) = 0;
    my($header_length) = 0;
    my($data_length) = 0;

    for($i = 0; $i < $#desc; $i += 2)
    {
	$tmpl .= $size_to_tmpl{$desc[$i + 1]};
	my($size) = length($desc[$i]);
	$max_size = $size if($size > $max_size);
    }
    my(@value) = unpack($tmpl, $data);

    for($i = 0, $j = 0; $i < $#desc; $i += 2, $j++)
    {
	if($desc[$i] ne "")
	{
	    my($fmt) = $size_to_fmt{$desc[$i + 1]};
	    my($pad) = " " x ($max_size - length($desc[$i]) + 1);
	    $header_length += ($desc[$i+1] =~ m/([0-9]+)/)?$1:0;
	    print OUT sprintf("$desc[$i]:$pad$fmt\n", $value[$j]);
	}
    }

    $data_length = ($desc[2] eq "Length" )?$value[1]:-1;
    if ( $data_length <= 0 ) { return ""; }
    return substr( $data, $header_length, $data_length - $header_length );
}

sub
get_descs
{
    @RSDP_DESC =
	("Signature", "A4",
	 "Signature2", "A4",
	 "Checksum", "X1",
	 "OEMID", "A6",
	 "", "X1",
	 "RsdtAddress", "X4");
    
    @RSDT_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Revision", "X1",
	 "Checksum", "X1",
	 "OEMID", "A6",
	 "OEM Table ID", "A8",
	 "OEM Revision", "X4",
	 "Creator ID", "A4",
	 "Creator Revision", "X4");
    
    @DSDT_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Revision", "X1",
	 "Checksum", "X1",
	 "OEMID", "A6",
	 "OEM Table ID", "A8",
	 "OEM Revision", "X4",
	 "Creator ID", "A4",
	 "Creator Revision", "X4");
    
    @FACP_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Revision", "X1",
	 "Checksum", "X1",
	 "OEMID", "A6",
	 "OEM Table ID", "A8",
	 "OEM Revision", "X4",
	 "Creator ID", "A4",
	 "Creator Revision", "X4",
	 "FIRMWARE_CTRL", "X4",
	 "DSDT", "X4",
	 "INT_MODEL", "X1",
	 "", "X1",
	 "SCI_INT", "D2",
	 "SMI_CMD", "X4",
	 "ACPI_ENABLE", "X1",
	 "ACPI_DISABLE", "X1",
	 "S4BIOS_REQ", "X1",
	 "", "X1",
	 "PM1a_EVT_BLK", "X4",
	 "PM1b_EVT_BLK", "X4",
	 "PM1a_CNT_BLK", "X4",
	 "PM1b_CNT_BLK", "X4",
	 "PM2_CNT_BLK", "X4",
	 "PM_TMR_BLK", "X4",
	 "GPE0_BLK", "X4",
	 "GPE1_BLK", "X4",
	 "PM1_EVT_LEN", "D1",
	 "PM1_CNT_LEN", "D1",
	 "PM2_CNT_LEN", "D1",
	 "PM_TM_LEN", "D1",
	 "GPE0_BLK_LEN", "D1",
	 "GPE1_BLK_LEN", "D1",
	 "GPE1_BASE", "D1",
	 "", "X1",
	 "P_LVL2_LAT", "D2",
	 "P_LVL3_LAT", "D2",
	 "FLUSH_SIZE", "D2",
	 "FLUSH_STRIDE", "D2",
	 "DUTY_OFFSET", "D1",
	 "DUTY_WIDTH", "D1",
	 "DAY_ALRM", "X1",
	 "MON_ALRM", "X1",
	 "CENTURY", "X1",
	 "", "X3",
	 "Flags", "X4");
    
    @FACS_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Hardware Signature", "X4",
	 "Firmware Waking Vector", "X4",
	 "Global Lock", "X4",
	 "Flags", "X4");

    @GEN_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Revision", "X1",
	 "Checksum", "X1",
	 "OEMID", "A6",
	 "OEM Table ID", "A8",
	 "OEM Revision", "X4",
	 "Creator ID", "A4",
	 "Creator Revision", "X4"
	 );

    
    my(%descs) =
	("RSD "=>\@RSDP_DESC,
	 "RSDT"=>\@RSDT_DESC,
	 "DSDT"=>\@DSDT_DESC,
	 "FACP"=>\@FACP_DESC,
	 "FACS"=>\@FACS_DESC,
	 "SLIT"=>\@GEN_DESC,
	 "SRAT"=>\@GEN_DESC,
	 "APIC"=>\@GEN_DESC,
	 "BOOT"=>\@GEN_DESC
	 );
    return %descs;
}






------=_Part_8213_12693154.1142440438102--
