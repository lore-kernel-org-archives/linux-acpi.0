From: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Subject: Re: Radeon Resuming from S3: Try 2
Date: Thu, 2 Dec 2004 13:41:41 -0500
Message-ID: <200412021341.42106.barr.156@osu.edu>
References: <200412012033.05893.barr.156@osu.edu> <1101981551.20007.7.camel@mhcln03>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1101981551.20007.7.camel@mhcln03>
Content-Disposition: inline
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
Cc: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 02 December 2004 04:59 am, Matthias Hentges wrote:
> Am Mittwoch, den 01.12.2004, 20:33 -0500 schrieb Andrew Barr:
> > Given the recent positive developments and success stories concerning
> > resuming ATI hardware from S3 suspend, I thought I'd give suspending my
> > desktop PC to S3. Briefly, relevant parts of my hardware:
>
> [...]
>
> > It appears I have two options: the s3_late_bios patch
> > or dummydriver/resume-finish-split. What do I need to do to try each one?
> > For example, I know I need to pass acpi_sleep=s3_late_bios to my kernel
> > to use that patch.
>
> correct
>
> > It's unclear to me what I need to do with the dummydriver or
> > resume-finish-split patches.
>
> Nothing. They don't need any kernel options to work. The dummydriver
> only works
> for two specific devices identified by their PCI-ID (or whatever you
> call that).
> It will *not* work for other devices.
>
> You'll have better luck using resume-finish-split as I didn't see
> anything device specific in there (well, I didn't look very long heh).
>
> These two patches don't help resuming your Radeon, they just prevent a
> freeze during resume caused by *other* devices.
>
> HTH

My machine does freeze after resuming from S3. Is this caused by other devices 
(like the sound card, uses ALSA driver snd-cmipci)? If I _just_ have the 
Radeon problem, the machine should work fine except for the monitor being 
dead, right? In other words, I should be able to SSH in (which I can't)? I 
was under the impression that both the video not coming back and the freeze 
were caused by the Radeon, because before I bought the Radeon I was using the 
on-board graphics controller (Intel 82865G) and there were no problems.

Andrew

P.S. If it'll help:

abarr@panthera ~ $ lspci
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub 
Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 
02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 
(rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI 
Controller #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface 
Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller 
(rev 02)
0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 
02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 
02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) 
AC'97 Audio Controller (rev 02)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE]
0000:02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:02:01.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 02)
0000:02:01.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 02)
0000:02:02.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 IEEE-1394 
Controller
0000:02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 
10)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
