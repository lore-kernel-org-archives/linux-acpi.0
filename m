From: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Re: [PATCH] cleanup ACPI numa warnings
Date: Sun, 08 Aug 2004 19:53:18 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <2550950000.1092019997@[10.10.2.4]>
References: <1091738798.22406.9.camel@tdi><1091739702.31490.245.camel@nighthawk><1091741142.22406.28.camel@tdi><249150000.1091763309@[10.10.2.4]><20040805205059.3fb67b71.rddunlap@osdl.org><20040807105729.6adea633.pj@sgi.com> <20040808143631.7c18cae9.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040808143631.7c18cae9.rddunlap-3NddpPZAyC0@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org>, Paul Jackson <pj-sJ/iWh9BUns@public.gmane.org>
Cc: alex.williamson-VXdhtT5mjnY@public.gmane.org, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--"Randy.Dunlap" <rddunlap-3NddpPZAyC0@public.gmane.org> wrote (on Sunday, August 08, 2004 14:36:31 -0700):

> On Sat, 7 Aug 2004 10:57:29 -0700 Paul Jackson wrote:
> 
>| > And there's nothing in CodingStyle that agrees with you that I could find.
>| 
>| > From the file Documentation/SubmittingPatches:
>| 
>|         3) 'static inline' is better than a macro
>| 
>|         Static inline functions are greatly preferred over macros.
>|         They provide type safety, have no length limitations, no formatting
>|         limitations, and under gcc they are as cheap as macros.
>| 
>|         Macros should only be used for cases where a static inline is clearly
>|         suboptimal [there a few, isolated cases of this in fast paths],
>|         or where it is impossible to use a static inline function [such as
>|         string-izing].
> 
> Oops.  Thanks, Paul.
> 
> I agree that the inline looks better than the macro (more readable,
> possibly more maintainable), but not that the multi-line macro
> is _evil_ (which is what Martin said).

It's not that this multi-line macro was particularly offensive ... it's
that I've seen the most heinous crap in the past ... and the only sensible
place I can find to draw a line is ... no multiline macros ;-)

M.



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
