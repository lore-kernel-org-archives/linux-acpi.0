From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] S4Bios support for 2.4.20 + acpi-20021205
Date: Fri, 13 Dec 2002 20:17:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021213191758.GP4327@poup.poupinou.org>
References: <20021213155309.GG4327@poup.poupinou.org> <20021213171431.045233f0.nils@kernelconcepts.de> <20021213163615.GI4327@poup.poupinou.org> <20021213181316.0b460077.nils@kernelconcepts.de> <20021213183622.GN4327@poup.poupinou.org> <20021213194907.5d99fc57.nils@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021213194907.5d99fc57.nils-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
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

On Fri, Dec 13, 2002 at 07:49:07PM +0100, Nils Faerber wrote:

[...]

> 
> My result:
> 	S4BIOS_REQ:       0x00
> 
> > For ./acpidmp FACS | ./acpitbl:
> > Flags have bit 0 set.
> 
> Signature:              FACS
> Length:                 64
> Hardware Signature:     0x00000000
> Firmware Waking Vector: 0x00000000
> Global Lock:            0x00000000
> Flags:                  0x00000000
> 
> Hmm ... and now?
> What does that mean?
> 

Your BIOS cry loudly that it do not support S4Bios (certainly due
to a lack of a suspend partition).  I supposed that my patch does it
right, so that if someone insist, it give up, but that is not the case.
I have to look what stupid brain-damaged bogosity I have written then.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
