From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: AMD64 - kernel freezes when inserting processor/powernow-k8 module
Date: Sun, 6 Jun 2004 21:51:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040606195128.GD10081@elf.ucw.cz>
References: <40BE06B2.5090808@renninger.de> <c051dde5040602102956373117@mail.gmail.com> <40BF699A.6020507@renninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40BF699A.6020507-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <mail-smMupaH/RwJM7kwft8N7nw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> >I too had problems with processor module on my thinkpad R40e. To see
> >how I fixed it go to
> >
> >http://www.flatface.net/~praveen/tp
> Cheers, this prevents the machine to hang.
> The hang is caused by some interference between the USB and firewire 
> modules.
> I recognised that the machine hangs when loading the processor module 
> when the ehci_hcd or ohci1394 module has been loaded before.
> Otherwise everything works fine...

If I load insmod ohci1394 and processor module is compiled-in, it
seems to work okay...

> Are there intentions to get this fixed, can I help/provide more info 
> somehow?

diff -u of a fix would be helpfull :-)))).

								Pavel

-- 
934a471f20d6580d5aad759bf0d97ddc


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
