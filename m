From: "Anthony J. Breeds-Taurima" <tony-xfCdrj5MXxYnC9Muvcwxkw@public.gmane.org>
Subject: Re: acpi-20021101 broken
Date: Tue, 5 Nov 2002 15:38:10 +0800 (WST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0211051536510.6335-100000@thor.cantech.net.au>
References: <1036480444.3dc76fbc753e6@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1036480444.3dc76fbc753e6-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 5 Nov 2002 moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org wrote:

> Hi!
> 
> I just tried out acpi-20021101 (patch against 2.4.20-rc1), but unfortunately it 
> seems to be broken. When booting, I see some kenel messages (I think I could 
> identify the processor-determination) and then the kernel seems to run into an 
> endless loop writing tons of messages to the console (nearly impossible to 
> read); but they all seem to have the same structure:
> 
> a few words "-" four digits "["for digits"]" "["two digits"]" some text ":" 
> some text

I think you want the patch at:
	http://sourceforge.net/mailarchive/message.php?msg_id=2390873


Yours Tony

   Jan 22-25 2003           Linux.Conf.AU            http://linux.conf.au/
		  The Australian Linux Technical Conference!



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
