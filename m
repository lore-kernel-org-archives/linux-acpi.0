From: Joshua Wise <joshua-NtISFavHD68j5TC/SZClsA@public.gmane.org>
Subject: ACPI on hp Tablet TC1100
Date: Thu, 24 Mar 2005 17:08:51 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0503241657510.4376@dashnine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi folks --

So, I did some more research on getting the tc1100 up and running under
Linux with full ACPI, and I've come across a method that can reliably bring
the system up from an "echo mem > state".

So, here's the state the system is in before I suspend it --

The nvidia module is unloaded. sshd is running. The broadcom ethernet
module, b44, is loaded, and has an IP. I am connected via SSH. ipw2100 is
unloaded. Sound is loaded.

I must UNLOAD uhci_hcd and ehci_hcd before suspending, and reload them
afterwards. Otherwise, they lock up, and flood my dmesg log with the following:

uhci_hcd 0000:00:1d.0: host controller process error, something bad happened!
uhci_hcd 0000:00:1d.2: host system error, PCI problems?

I then sync my disks, cd to /sys/power/, and run the following Massive
Command Line(tm):

echo mem > state; sleep 1; ifconfig eth0 down; rmmod b44; echo b44 down;
sleep 1; modprobe b44; sleep 3; echo b44 up; ifconfig eth0 up; sleep 3;
ifconfig eth0 192.168.1.171; echo b44 ip; sleep 1; sync; mpg123
/home/joshua/ThisIsWaitWait.wav.mp3

Basically, this brings the system down. Once it comes back up, it
reinitializes b44, syncs disks in case I don't manage to SSH in or whatever
to power it down cleanly, and plays an MP3 to let me know that it's alive.

I can then SSH in and load ipw2100 drivers, as well as uhci_hcd and ehci_hcd
drivers. USB becoms functional. I have pci=noacpi set at present.

I CANNOT start X after this (I am using the binary nvidia driver). As far as
I can tell, X does not even load the NVIDIA drivers, but instead hangs while
setting up PCI.

Video is still nonexistant at that point -- if I do a vbetool post, though,
I get a nice blinking cursor, and a few bangs of the enter key later, I get
my console back. I will try acpi_sleep=s3_bios. I would've tried it already,
but I didn't see the _, and hence tried acpi_sleep=s3bios, to no avail. I'll
also try it without pci=noacpi, and we'll see how things go from there.

I am running 2.6.11.5 with acpi-20050309-2.6.11.diff.bz2 and
software-suspend-2.1.8.2-for-2.6.11.

Anyone interested in the X.org startup log can find it at
http://joshuawise.com/~joshua/Xorg.0.log .

Does anyone see anything that I'm doign wrong, or that I should be doing
that I'm not?

Thanks,
Joshua


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
