From: Simon Bridge <corwin-OA6R/WnsTSZ02iOg2JU2CQ@public.gmane.org>
Subject: 0 bytes read from /DSDT.aml ?!
Date: Wed, 07 Dec 2005 20:53:14 +1300
Message-ID: <439694EA.5080603@ihug.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Using Ubuntu Breezy with 2.6.12 on Acer Aspire 3003LC
Install custom DSDT.aml as follows:

# iasl -ta dsdt.dsl

(no errors)

# cp DSDT.aml /etc/mkinitramfs/DSDT.aml
# dpkg-reconfigure linux-image-`uname -r`

reboot

/proc/apci dosn't exist
dmesg swamped with APIC errors: set noapic on grub kernel line and reboot.

/proc/acpi still don't exist - well of course not...

dmesg | grep ACPI

[4294669.728000] ACPI: Looking for DSDT in initramfs... found /DSDT.aml ... successfully read 0 bytes from /DSDT.aml
[4294669.728000] ACPI: Using customized DSDT
[4294669.728000]     ACPI-0229: *** Warning: Invalid checksum in table [    ] (00, sum 54 is not zero)
[4294669.728000]     ACPI-0306: *** Info: Table [    ] replaced by host OS
[4294669.764000]     ACPI-0320: *** Error: ns_search_and_enter: Bad character in ACPI Name: CBEEDF
[4294669.764000]     ACPI-0295: *** Error: Looking up [0xCBEEDF] (NON-ASCII)
[4294669.765000]     ACPI-0127: *** Error: acpi_load_tables: Could not load namespace: AE_BAD_CHARACTER
[4294669.765000]     ACPI-0136: *** Error: acpi_load_tables: Could not load tables: AE_BAD_CHARACTER
[4294669.765000] ACPI: Unable to load the System Description Tables
[4294669.866000] ACPI: Subsystem revision 20050729
[4294669.866000] ACPI: Interpreter disabled.
[4294669.866000] pnp: PnP ACPI: disabled

... that first line would appear to be the problem.

I note that there are windows specific conditionals in the dsl, basically to store OS-specific values to ^OSTB and 
^TPOS. The values assigned for _OS is not in the list is 0x00. I don't see how this could result in the above behaviour, 
but - oh well... nothing ventured... the only result of setting acpi_os_name= to any of the windows versions in the dsl 
is to add the line: ACPI: Overriding _OS definition to '<whatever>' : before looking for DSDT in initramfs. The rest is 
all the same. The vendor supplied OS was MS Windows XP Home Edition ... which is not in the dsl either.

I looked for statements like If (LEqual (SizeOf (_OS), 0x14)) - but there ain't none.

Advice?

Can anyone recommend an AML programming manual or guide?
(I am old-time programmer, cut my teeth on machine code - so you needent be shy suggesting technical references).

Looking through dsdt.dat slowly, I see references to APIC: could it be that the DSDT is telling ACPI to use APIC 
instead? And since I have booted "noapic" then nothing is read? Is this even sane?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
