From: Bjorn Wesen <bjorn.wesen-VrBV9hrLPhE@public.gmane.org>
Subject: Re: S3 works on Dell i2650, but no display
Date: Wed, 28 May 2003 02:26:09 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.33.0305280221440.20262-100000@godzilla.se.axis.com>
References: <20030524155445.GA262@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030524155445.GA262-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Luke Hammer <lukeh-rdE3vRTOlSC6c6uEtOJ/EA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 24 May 2003, Pavel Machek wrote:
> > When I tried to resume however, I found that the console display
> >didn't come back on - though I knew the machine was responsive because
> >I could type commands

> You might need to get datasheet to your videocard and write specific
> support. Also try lspci before and after suspend etc. [But don't
> expect this to be easy].

Hi!

Isn't this a general problem on all notebooks - even if you know everything 
about the videocard used, might not the notebook use a completely different 
mechanism for actually turning on and off the display (with backlight etc) ?

I remember we had a similar discussion a while ago when I tried to get S3 
working on my Acer notebook and the only way to enable that backlight was 
through the bios lcall. Then 2.5.69 came, S3 broke again on the Acer, and I 
haven't tested anything more :) 

What is done in the other notebooks that actually have S3 working - do their 
screens default to backlight-on when the hardware gets powered on, do they 
use the lcall, or is there some other magic possible ? Can we systematically 
solve that proble I mean ?

/Bjorn




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
