From: Paul Jackson <pj-sJ/iWh9BUns@public.gmane.org>
Subject: Re: Re: [PATCH] cleanup ACPI numa warnings
Date: Sat, 7 Aug 2004 10:57:29 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040807105729.6adea633.pj@sgi.com>
References: <1091738798.22406.9.camel@tdi>
	<1091739702.31490.245.camel@nighthawk>
	<1091741142.22406.28.camel@tdi>
	<249150000.1091763309@[10.10.2.4]>
	<20040805205059.3fb67b71.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040805205059.3fb67b71.rddunlap-3NddpPZAyC0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>
Cc: mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org, alex.williamson-VXdhtT5mjnY@public.gmane.org, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> And there's nothing in CodingStyle that agrees with you that I could find.

>From the file Documentation/SubmittingPatches:

        3) 'static inline' is better than a macro

        Static inline functions are greatly preferred over macros.
        They provide type safety, have no length limitations, no formatting
        limitations, and under gcc they are as cheap as macros.

        Macros should only be used for cases where a static inline is clearly
        suboptimal [there a few, isolated cases of this in fast paths],
        or where it is impossible to use a static inline function [such as
        string-izing].

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj-sJ/iWh9BUns@public.gmane.org> 1.650.933.1373


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
