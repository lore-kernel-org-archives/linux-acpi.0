From: "greg" <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: meaning of sizeof(_OS)?
Date: Mon, 26 Jan 2004 13:20:06 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040126182006.M9076@morningdave.org>
References: <20040126111648.GA2004@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040126111648.GA2004-4cxDFgrrBECgSpxsJD1C4w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Micha,

   It's tough to know what the DSDT wants to do differently with the _OS 
checks without seeing the actual DSDT, as it varies from system to system.

   I think that 0x27 is checking for "Microsoft WindowsME: Millennium 
Edition" (39 characters).

   The LEqual is a Logical Equal. From the spec:


16.2.3.4.2.21  LEqual (Logical Equal)
LEqualTerm	:= LEqual(
	Source1,	//TermArg=>ComputationalData
	Source2	//TermArg=>ComputationalData
) => Boolean
Source1 and Source2 must be evaluated to the same data type as integers, 
strings, or buffers. If the values are equal, True is returned; otherwise, 
False is returned.


  Hope that helps clarify a bit.
  Greg




---------- Original Message -----------
From: Micha Feigin <michf-+lLcF8/aw9x6auLlOhE+pQ@public.gmane.org>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sent: Mon, 26 Jan 2004 13:16:48 +0200
Subject: [ACPI] meaning of sizeof(_OS)?

> Was wondering at least theoretically what is supposed to be done
> different by the dsdt if the os is M$ NT/XP since I saw there is an
> explicit check of _OS against "Microsoft Windows NT".
> Also I saw some people talking about a size check of the _OS variable
> against 0x14 to see if its the M$ os. In my dsdt the check is for 
> some reason against 0x27, any idea what os its looking for? (is 
> LEqual less then or equall or does the L mean something else?)
> 
> Thanx
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
------- End of Original Message -------



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
