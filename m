From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Dothan VID# identification script (was Re: Speedstep-centrino
 problems)
Date: Sat, 12 Feb 2005 18:28:27 -0500
Message-ID: <420E911B.1060405@bartol.udel.edu>
References: <0FEA36BB2ABDF44FAAFEB7A75367C07A0117DCE4@alaska.condis.es> <420B5CB1.2090804@bartol.udel.edu> <20050210172904.GB6824@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030207060604050608070005"
In-Reply-To: <20050210172904.GB6824-JwFqNg2GrOVrgjWwlLH9qw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: Simon Moore <Simon_Moore-HnN13UdsTkzz1n+OaKNE4w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------030207060604050608070005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dominik Brodowski wrote:
>>The problem is not so much to do with the ability to choose the 
>>appropriate VID#, it is more about working out *which* VID# to choose. 
>>If someone could address the latter question, I'd be more than happy to 
>>have a shot at the former.
> 
> 
> At some frequency levels, you can read out the current settings and
> determine which VID# is used. At other frequency levels, you cannot,
> though, as some VID# can have the same voltage for certain levels.
> Therefore, I do not see a runtime-way to determine the correct VID# to
> choose.
> 
> 	Dominik

The attached Perl script demonstrates one run-time approach to 
determining the correct VID# to use. In principle, this approach could 
be integrated into the kernel, to allow Pentium M Dothan support to be 
added to speedstep-centrino.

Rather paradoxically, for this script to work, cpufreq must already be 
up and running. This is because the script uses the entries in 
/sys/devices/.../cpufreq to get a *provisional* list of processor 
frequencies. It is expected that this list be obtained from the 
processor P-state information in the DSDT, so for the script to work, 
make sure you have the acpi_cpufreq table helper installed (see 
instructions at the end of this post).

The script iterates through the provisional frequency list, setting the 
processor frequency using the scaling_[max|min]_freq files in 
/sys/devices/.../cpufreq. The frequency and voltage are then read back 
using the IA32_PERF_STATUS MSR. This way, a frequency/voltage table is 
built up for the system. Each entry of the table is *guaranteed* to be a 
valid frequency/voltage pair, although some frequencies may be missing 
from the table due to DSDT bugs (on my 1.6Ghz Dothan system, the DSDT 
mislabels the 1000 MHz frequency, and omits the 800 Mhz frequency).

The frequency/voltage table is then cross-checked against *all* of the 
Pentium M Dothan tables published by Intel (i.e., all of the possible 
processor and VID# combinations). If there is a single, *unique* match, 
then the Perl script prints out this match, plus the *full* 
frequency/voltage table (including entries that the DSDT may have 
missed). Example output on my system is as follows:

Identified Intel(r) Pentum(r) M Processor 725 Core, 1.6 Ghz, VID#A
Frequency/voltage table:
  600 MHz        ->      988 mV
  800 MHz        ->      1068 mV
  1000 MHz       ->      1132 mV
  1200 MHz       ->      1212 mV
  1400 MHz       ->      1276 mV
  1600 MHz       ->      1340 mV

Of course, we can't guarantee that there will always be a match; or that 
there won't be duplicate matches. Also, this approach relies on having 
ACPI P-states, to build up the frequency/voltage table. However, it 
still seems to me to be a pretty robust way of determining the VID# in a 
system, and one that could be incorporated into speedstep-centrino. 
Dominik, what do you think?

cheers

Rich

PS Almost forgot: for those wanting to use the script, make sure you 
have cpufreq enabled in your kernel, and make sure the ACPI Processor 
P-states driver is installed (CONFIG_X86_ACPI_CPUFREQ), and that you 
also have the userspace governor installed 
(CONFIG_CPU_FREQ_GOV_USERSPACE). Then, just run the script *as root*, 
with no arguments.

--------------030207060604050608070005
Content-Type: text/plain;
 name="dothan_id.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dothan_id.pl"

#!/usr/bin/perl -w
#
#  dothan_id.pl
#
#  (c) 2005 Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
#
# Script to identify the voltage ID (VID#) of a 
# Pentium M Dothan CPU

# Constants

$CPUFREQ_DIR = "/sys/devices/system/cpu/cpu0/cpufreq";

$MSR_FILE = "/dev/cpu/0/msr";
$MSR_IA32_PERF_STATUS = 0x198;

$DEBUG = 0;

# Enumerate the avaliable frequencies

@afreqs = split(' ', cpufreq_read('scaling_available_frequencies'));

# Set the governor to userspace

cpufreq_write('scaling_governor', 'userspace');
cpufreq_read('scaling_governor') eq 'userspace' or die "Unable to set governor to userspace\n";

# Iterate through the available frequencies, building
# up the frequency/voltage table

%freq_table = ();

foreach my $afreq (sort { $a <=> $b } @afreqs) {

# Set the current frequency

    cpufreq_write('scaling_max_freq', $afreq);
    cpufreq_write('scaling_min_freq', $afreq);

    cpufreq_read('scaling_cur_freq') == $afreq or die "Unable to set frequency to $afreq\n";

# Read back the frequency and voltage into using
# the MSR

    my $msr_str;

    open MSR_FILE, "<$MSR_FILE" or die "Unable to read from $MSR_FILE\n$!";
    seek MSR_FILE, $MSR_IA32_PERF_STATUS, 0;
    read MSR_FILE, $msr_str, 8;
    close MSR_FILE;

    my $msr_val = 0;
    
    for(my $i = 0; $i < 8; $i++) {
	$msr_val <<= 8;
	$msr_val += ord(substr($msr_str, 7-$i, 1));
    }

    $msr_val &= 0xffffffff;

    my $freq = 100*($msr_val>>8 & 0xff);
    my $volt = 16*($msr_val & 0xff) + 700;

    $freq_table{$freq} = $volt;

    $DEBUG && printf("Available frequency %d gives frequency %d MHz @ %d mV\n", $afreq, $freq, $volt);
}

# Set up the voltage data table, taken from Intel's 
# January 2005 datasheet for the Pentium M Dothan

%DOTHAN_DATA = (
		715 => {
		    'rating' => '1.5',
		    'freqs' => [600, 800, 1000, 1200, 1500],
		    'VIDs' => {
			'A' => [988, 1068, 1148, 1228, 1340],
			'B' => [988, 1068, 1148, 1212, 1324],
			'C' => [988, 1068, 1132, 1212, 1308],
			'D' => [988, 1052, 1116, 1180, 1276]
			}
		},
		725 => {
		    'rating' => '1.6',
		    'freqs' => [600, 800, 1000, 1200, 1400, 1600],
		    'VIDs' => {
			'A' => [988, 1068, 1132, 1212, 1276, 1340],
			'B' => [988, 1068, 1132, 1196, 1260, 1324],
			'C' => [988, 1052, 1116, 1180, 1244, 1308],
			'D' => [988, 1052, 1116, 1164, 1228, 1276]
			}
		},
		735 => {
		    'rating' => '1.7',
		    'freqs' => [600, 800, 1000, 1200, 1400, 1700],
		    'VIDs' => {
			'A' => [988, 1052, 1116, 1180, 1244, 1340],
			'B' => [988, 1052, 1116, 1180, 1244, 1324],
			'C' => [988, 1052, 1116, 1164, 1228, 1308],
			'D' => [988, 1052, 1100, 1148, 1212, 1276]
			}
		},
		745 => {
		    'rating' => '1.8',
		    'freqs' => [600, 800, 1000, 1200, 1400, 1600, 1800],
		    'VIDs' => {
			'A' => [988, 1052, 1116, 1164, 1228, 1292, 1340],
			'B' => [988, 1052, 1100, 1164, 1212, 1276, 1324],
			'C' => [988, 1052, 1100, 1148, 1212, 1260, 1308],
			'D' => [988, 1036, 1084, 1132, 1180, 1228, 1276]
			}
		},
		755 => {
		    'rating' => '2.0',
		    'freqs' => [600, 800, 1000, 1200, 1400, 1600, 1800, 2000],
		    'VIDs' => {
			'A' => [988, 1052, 1100, 1148, 1196, 1244, 1292, 1340],
			'B' => [988, 1036, 1084, 1132, 1180, 1228, 1276, 1324],
			'C' => [988, 1036, 1084, 1132, 1180, 1228, 1276, 1308],
			'D' => [988, 1036, 1084, 1116, 1164, 1196, 1244, 1276]
			}
		},
		765 => {
		    'rating' => '2.1',
		    'freq' => [600, 800, 1000, 1200, 1400, 1600, 1800, 2100],
		    'VIDs' => {
			'A' => [988, 1036, 1084, 1132, 1180, 1228, 1276, 1340],
			'B' => [988, 1036, 1084, 1132, 1180, 1212, 1260, 1324],
			'C' => [988, 1036, 1084, 1116, 1164, 1212, 1244, 1308],
			'E' => [988, 1052, 1100, 1148, 1196, 1244, 1292, 1356]
			}
		}
		);

# Attempt to match the frequency table against one
# of the Dothan tables

@match_cpus = ();
@match_VIDs = ();

foreach $cpu (keys %DOTHAN_DATA) {

    foreach $VID (keys %{$DOTHAN_DATA{$cpu}->{'VIDs'}}) {

# Dynamically create a table for the current cpu/VID
# pair

	my %dothan_freq_table = ();

	for(my $i_freq = 0; $i_freq <= $#{$DOTHAN_DATA{$cpu}->{'freqs'}}; $i_freq++) {
	    my $freq = $DOTHAN_DATA{$cpu}->{'freqs'}->[$i_freq];
	    my $volt = $DOTHAN_DATA{$cpu}->{'VIDs'}->{$VID}->[$i_freq];
	    $dothan_freq_table{$freq} = $volt;
	}
			 
# See whether the frequency table is a 
# subset of the Dothan table

	my $match = 1;

	foreach my $freq (keys %freq_table) {
	    if(!exists($dothan_freq_table{$freq}) ||
	       $dothan_freq_table{$freq} != $freq_table{$freq}) {
		$match = 0;
		last;
	    }
	}
	    
# If a match was found, store the cpu and VID

	if($match) {
	    push @match_cpus, $cpu;
	    push @match_VIDs, $VID;
	}
	
    }
}	
	
# Print out the results

if(@match_cpus == 0) {

    print "No matches found\n";

}
elsif(@match_cpus == 1) {

    my $cpu = $match_cpus[0];
    my $VID = $match_VIDs[0];

    printf("Identified Intel(r) Pentum(r) M Processor %d Core, %2.1f Ghz, VID#%s\n", 
	   $cpu, $DOTHAN_DATA{$cpu}->{'rating'}, $VID);

    printf("Frequency/voltage table:\n");

    for(my $i_freq = 0; $i_freq <= $#{$DOTHAN_DATA{$cpu}->{'freqs'}}; $i_freq++) {
	my $freq = $DOTHAN_DATA{$cpu}->{'freqs'}->[$i_freq];
	my $volt = $DOTHAN_DATA{$cpu}->{'VIDs'}->{$VID}->[$i_freq];
	printf(" %d MHz\t->\t%d mV\n", $freq, $volt);
    }

}
else {

    print "Duplicate matches found, no identification possible\n";

}

# Finish

sub cpufreq_read {

    open CPUFREQ, "<$CPUFREQ_DIR/$_[0]" or die "Unable to read from $CPUFREQ_DIR/$_[0]\n$!";
    my $line = <CPUFREQ>;
    close CPUFREQ;

    chomp $line;

    return $line;

}

sub cpufreq_write {

    open CPUFREQ, ">$CPUFREQ_DIR/$_[0]" or die "Unable to write to $CPUFREQ_DIR/$_[0]\n$!";
    print CPUFREQ $_[1];
    close CPUFREQ;

}

--------------030207060604050608070005--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
