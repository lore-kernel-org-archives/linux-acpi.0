From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 13:38:19 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502113819.GJ2954@poup.poupinou.org>
References: <B900970C7DD9474C972986EB3EC7C58F12EC9A@andromeda.agcad.local> <20030502103102.A2867@fermat.unipv.it> <3EB23932.9090508@gkec.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3EB23932.9090508-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan Behnel <behnel_ml-8NdywcgfOMlWMvVl7B+zuCEWGD4kr0XT@public.gmane.org>
Cc: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 02, 2003 at 11:24:02AM +0200, Stefan Behnel wrote:
> 
> Daniele Boffi wrote:

[]

> 
> Try to find out then. As long as you keep an eye on the CPU temperature, 
> you're unlikely to burn it.
> 
> 
> >If there is
> >any documentation about that, please let me know (for instance, I found 

It is in the ACPI spec.  There is also an example in the thermal
chapter on how to implement a 2 speed fan which seems to be the
same as for your laptop.

> >echo 0
> >and echo 3 just by guessing).
> 
> I don't know. But 0-5 are the general ACPI power states, 0 being "on" and 
> "5" being "off". 1-4 are different shades in between.

To be more precise, there is 6 system state (S0 system functional,
S5 system off), but 'only' 4 for devices in general (G0 fully on, G3 off).

The meaning for the Gx is more or less different, since
this is dependant of the bus from which the device is attached.
Please look at the spec for more info about this.

Cheers,
-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
