From: Len Brown <len.brown@intel.com>
Subject: Re: fadt.boot_flags.MSI_not_supported
Date: Thu, 28 Sep 2006 00:43:44 -0400
Message-ID: <200609280043.44794.len.brown@intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6019B425D@hdsmsx411.amr.corp.intel.com> <20060927212315.59ccbbe4.rdunlap@xenotime.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AM1GFvEAeqccvd2"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:25476 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751439AbWI1Elu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 00:41:50 -0400
In-Reply-To: <20060927212315.59ccbbe4.rdunlap@xenotime.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-acpi@vger.kernel.org

--Boundary-00=_AM1GFvEAeqccvd2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 28 September 2006 00:23, Randy Dunlap wrote:
> On Wed, 27 Sep 2006 20:14:58 -0400 Brown, Len wrote:
> 
> > sifting through ACPI 3.0a I just noticed a bit (3)
> > in the FADT boot_flag to indicate the platform
> > does not support MSI.
> > 
> > Has anybody noticed fadt.boot_flags bit 3 set on their box?
> 
> Would we observe that in kernel boot messages or by using
> acpidump?

Using the acpitbl script attached:

# cat /proc/acpi/fadt |acpitbl |grep IAPC_BOOT_FLAGS
IAPC_BOOT_FLAGS:  0x0003

(this example has bit 0 and 1 set, we are looking for bit 3).

If you have an acpidump output, you can do it this way

$ acpixtract FACP acpidump.out | acpitbl | grep IAPC_BOOT_FLAGS
IAPC_BOOT_FLAGS:  0x0003

--Boundary-00=_AM1GFvEAeqccvd2
Content-Type: application/x-perl;
  name="acpitbl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acpitbl"

#!/usr/bin/perl
#
# acpitbl - ACPI table dumper
#
# Example: ./acpidmp FACP | ./acpitbl
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

    &show_table(OUT, $DESCS{$signature}, \$data);

    return 0;
}

sub
show_table
{
    local(*OUT, *desc, *data) = @_;
    my(%size_to_tmpl) =
	("D1"=>"C", "D2"=>"S",  "D4"=>"I",
	 "X1"=>"C", "X2"=>"S",  "X3"=>"a3",
	 "X4"=>"I", "A4"=>"A4", "A6"=>"A6",
	 "A8"=>"A8");
    my(%size_to_fmt) =
	("D1"=>"%d", "D2"=>"%d", "D4"=>"%d",
	 "X1"=>"0x%02x", "X2"=>"0x%04x", "X3"=>"0x%06x",
	 "X4"=>"0x%08x", "A4"=>"%s", "A6"=>"%s",
	 "A8"=>"%s");

    my($tmpl) = "";
    my($max_size) = 0;
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
	    print OUT sprintf("$desc[$i]:$pad$fmt\n", $value[$j]);
	}
    }
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
	 "IAPC_BOOT_FLAGS", "X2",
	 "", "X1",
	 "Flags", "X4");
    
    @OEMB_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Revision", "X1",
	 "Checksum", "X1",
	 );

    @FACS_DESC =
	("Signature", "A4",
	 "Length", "D4",
	 "Hardware Signature", "X4",
	 "Firmware Waking Vector", "X4",
	 "Global Lock", "X4",
	 "Flags", "X4");

    my(%descs) =
	("RSD "=>\@RSDP_DESC,
	 "RSDT"=>\@RSDT_DESC,
	 "DSDT"=>\@DSDT_DESC,
	 "FACP"=>\@FACP_DESC,
	 "OEMB"=>\@RSDT_DESC,
	 "MCFG"=>\@RSDT_DESC,
	 "APIC"=>\@RSDT_DESC,
	 "FACS"=>\@FACS_DESC);
    return %descs;
}

--Boundary-00=_AM1GFvEAeqccvd2--
