From: Dimitris Stasinopoulos <dimitris-1R3Ry79yXbc@public.gmane.org>
Subject: Re: Asus ACPI Hotkeys
Date: Sat, 3 May 2003 19:04:17 +0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200305031904.17707.dimitris@linea.gr>
References: <20030503112602.3d2ac1c3.g.zwartjes@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030503112602.3d2ac1c3.g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gertjan <g.zwartjes-oe7qfRrRQfdlL9U78CI+FQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Saturday 03 May 2003 12:26, Gertjan wrote:
> Hi,
>
> I recently bought an Asus Laptop from the L3 series. It has hotkeys, or
> multimedia buttons, for volume up, down, mute, internet, mail etcetera.
> Especially the volume up, down and mute are the buttons I would like to
> see working.
>

Please note that in most cases, the volume buttons have nothing to do with 
ACPI. Run "showkey -s", hit any of these keys and see if they register any 
codes. If they do, then you're good to go. On my notebook (Compaq 1722EA), 
that is the case, and I use xevact under X to use them.

Dimitris

--
"The end of time is reached around the year 8000, by which time we expect Qt 
to be obsolete."

- QT Documention, qdate.html#details


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
