From: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] S4Bios support for 2.4.20 + acpi-20021205
Date: Fri, 13 Dec 2002 19:49:07 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213194907.5d99fc57.nils@kernelconcepts.de>
References: <20021213155309.GG4327@poup.poupinou.org>
	<20021213171431.045233f0.nils@kernelconcepts.de>
	<20021213163615.GI4327@poup.poupinou.org>
	<20021213181316.0b460077.nils@kernelconcepts.de>
	<20021213183622.GN4327@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021213183622.GN4327-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Cc: ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 13 Dec 2002 19:36:22 +0100
Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> On Fri, Dec 13, 2002 at 06:13:16PM +0100, Nils Faerber wrote:
> > On Fri, 13 Dec 2002 17:36:15 +0100
> > Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> > > On Fri, Dec 13, 2002 at 05:14:31PM +0100, Nils Faerber wrote:
> > > > On Fri, 13 Dec 2002 16:53:09 +0100
> > > > Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> > > > > Patch for 2.4.20 and acpi-20021205 for adding s4bios feature.
> > > Well, I don't know.  Perhaps lphdisk (I don't remember the URI)
> > > could help.  Some googling permit to get it.  Or (who knows?) even
> > > a/dev/hda1 as a vfat partition can help?
> > 
> > AFAIK this is only good for Phoenix BIOS whereas mine is AWARD
> > Medallion. Couldn't this also be specified in ACPI specs, i.e. how a
> > suspend partition has to look like?
> 
> You will find nothing.  This is not ACPI problem, but a BIOS one.

Surely, but I was also speaking about "ideal world" :)

> > > > does it suspend? I know for Phoenix BIOSes there is a tool on
> > > > the net to create that partition. I have a Asus L3800C notebook
> > > > which has AFAIK an AWARD BIOS. And AFAIK there is no tool
> > > > available from ASUS or AWARD to create such a partition.
> > > In a really perfect world:
> > > echo 1 > /proc/acpi/sleep	# for standby
> > > echo 2 > /proc/acpi/sleep	# for suspend to ram
> > > echo 3 > /proc/acpi/sleep	# for suspend to ram, but with more power conservative
> > > echo 4 > /proc/acpi/sleep	# for suspend to disk
> > > echo 5 > /proc/acpi/sleep	# for shutdown unfriendly the system
> 
> I wanted only to speak for a 'perfect world', not for what is the
> patch. My apologies for confusion.

Sure, I think I was not clear about what I said.

> > That would really be perfect :)
> > S1 on mine does just switch of the fan and stops the CPU. Nothing
> > more. S2 does not exist.
> > S3 does nothing except for funny ACPI messages:
> > 	acpi: sleep 3
> > 	acpi: GO!
> > 	acpi: acpi_suspend call 3
> > 
> > And your S4BIOS patch ends up freezing the machine after "saving CPU
> > context". Oh, but S5 behaves as expected :)
> 
> My patch is NOT for S3.

Yep, knew that :) Just wanted to let you (and others maybe) know.

> S4bios requrire that the bios have necessary support.  I check that
> it has before going to s4bios. Could you please :
> 
> get pmtools from Intel site:
> http://developer.intel.com/technology/iapc/acpi/downloads.htm
> 
> Then under pmtools-20010730:
> make
> cd acpidmp
> Could you then send me output of:
> ./acpidmp FACP | ./acpitbl
> and
> ./acpidmp FACS | ./acpitbl
> 
> I check for those values:
> For ./acpidmp FACP | ./acpitbl
> S4BIOS_REQ is not 0;

My result:
	S4BIOS_REQ:       0x00

> For ./acpidmp FACS | ./acpitbl:
> Flags have bit 0 set.

Signature:              FACS
Length:                 64
Hardware Signature:     0x00000000
Firmware Waking Vector: 0x00000000
Global Lock:            0x00000000
Flags:                  0x00000000

Hmm ... and now?
What does that mean?

> I supposed that the latest check would be sufficient?

No idea.
Maybe I should start to read the ACPI spec I downloaded some time ago :)

> Ducrot Bruno
CU
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
