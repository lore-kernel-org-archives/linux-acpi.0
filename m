From: Dirk Meul <dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: Re: S1 could work
Date: Tue, 27 Jan 2004 20:45:09 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075232709.2673.14.camel@aragorn>
References: <Pine.LNX.4.58.0401201816420.4869@localhost.localdomain>
 <20040122102912.GA355@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20040122102912.GA355-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Do, den 22.01.2004 schrieb Pavel Machek um 11:29:
> Switching consoles doing S1 is not neccessary on working hardware. You
> might want to simply comment it out.

Can you give me a pointer where switching is done? I could not find it.

Trying to enter S1 when pdnsd is running aborts standby. But pdnsd is
killed by entering S1 or S3 (didn't know S4 because it didn't work for
me). Entering S3 with a running pdnsd works.

By entering S1 audio from my tv-card will not stopped.

Resuming from S3 will only work if i unload all sound modules. But i'm
not able to reload them successfully:
Starting ALSA (version 1.0.1):AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0xffffffff], removing mixer.
EMU10K1_Audigy: probe of 0000:00:0d.0 failed with error -5
 emu10k1 bt87x.
Restoring ALSA mixer settings ... done.

Without sound module unloading there is:
Kernel panic: Fatal exception in interrupt

Best regards,
-- 
                                  /"\
Dirk Meul                         \ /    ASCII Ribbon Campaign
dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org           X     Against HTML Mail
                                  / \




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
