From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: [2.5.69] S3 does not come back / Sony Vaio C1MHP
Date: Tue, 27 May 2003 16:24:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1054045474.6896.6.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <20030527101501.GB1247@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030527101501.GB1247-L3tpvOS5ZD2KugBFyThYrEB+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Die, 2003-05-27 um 12.15 schrieb Florian Lohoff:
> Sony Vaio C1MHP 
> Transmeta TM5800

I can definetely confirm the very same behaviour for

Sony Vaio Z600TEK
Intel PIII-750

> goes to sleep - The power led turns blinking red - good sign - after
> pressing the powerbutton the machine powers up (Powerled turns green and
> batterie led turns orange) but nothing happens. Backlight does not turn 
> on nor does the disk do anything. From looking at the screen in bright
> light it does not write anything to it.
> 
> I need to disconnect the battery to get to a defined state again. The
> power-button does nothing and even then the first power-on does
> nothing - need to powercyle once after battery disconnect.

I tried lots of different stuff (see mail archives) and came to the
conclusion that it does never jump to the wakeup address indeed. So it
seems that either that some hardware does not correctly get prepared for
sleep and it thus hangs in pre-OS-controlled (whats the correct term
here?) code when waking up or there is a bug in sonys pre-OS-controlled
code.

i thought of trying to set OS String to Windows NT or something but did
not try that yet...

Regards
-Knut



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
