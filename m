From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] S4Bios support for 2.4.20 + acpi-20021205
Date: Fri, 13 Dec 2002 17:36:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213163615.GI4327@poup.poupinou.org>
References: <20021213155309.GG4327@poup.poupinou.org> <20021213171431.045233f0.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021213171431.045233f0.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Dec 13, 2002 at 05:14:31PM +0100, Nils Faerber wrote:
> On Fri, 13 Dec 2002 16:53:09 +0100
> Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> wrote:
> > Patch for 2.4.20 and acpi-20021205 for adding s4bios feature.
> 
> Hey, that sounds great!
> Just a little question: How do I use it :)
> 
> Don't think I am stupid...
> I know that a echo 1 > /proc/acpi/sleep should do the trick, i.e.
> suspend to disk. But how do I configure that suspend partition? Or where

Well, I don't know.  Perhaps lphdisk (I don't remember the URI) could
help.  Some googling permit to get it.  Or (who knows?) even a /dev/hda1
as a vfat partition can help?

> does it suspend? I know for Phoenix BIOSes there is a tool on the net to
> create that partition. I have a Asus L3800C notebook which has AFAIK an
> AWARD BIOS. And AFAIK there is no tool available from ASUS or AWARD to
> create such a partition.

In a really perfect world:
echo 1 > /proc/acpi/sleep	# for standby
echo 2 > /proc/acpi/sleep	# for suspend to ram
echo 3 > /proc/acpi/sleep	# for suspend to ram, but with more power conservative
echo 4 > /proc/acpi/sleep	# for suspend to disk
echo 5 > /proc/acpi/sleep	# for shutdown unfriendly the system

and perhaps
echo 4b > /proc/acpi/sleep	# for suspend to disk via s4bios

Actually, since there is no S4 support in 2.4, 4 and 4b is the same here.

Please note also that this patch DO NOT fix devices suspensions codes in
general, and have certainly some data corruption that need to be fixed
before a real inclusion.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
