From: John Belmonte <john-wanGne27zNesTnJN9+BGXg@public.gmane.org>
Subject: Re: ACPI HOWTO
Date: Mon, 17 May 2004 20:13:05 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40A95511.3070109@neggie.net>
References: <20040517190137.GD5547@smeagol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040517190137.GD5547-Kz9ENIl45+A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Cc: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Emma Jane Hogbin wrote:
> I've just published an updated version of the ACPI HOWTO. It is available
> at:
> 	http://www.tldp.org/HOWTO/ACPI-HOWTO/index.html
> I know everyone's busy...but I was hoping that I could get a few eyes on
> the text at some point. I'd like to create a section that has "gotchas"
> listed by kernel version, but I haven't quite decided where to put that
> information yet (perhaps as an appendix?). I've already moved the patch
> information to an appendix as it shouldn't be relevant once the bugs
> are ironed out of the 2.6.x series kernel...right?

I looked at this briefly on your first announcement, and felt that there 
is a conceptual problem with the document.  Half of it seems to be 
dedicated to compiling and installing kernels, which is covered in other 
HOWTO's and guides, Debian way or otherwise.

It may be that when you started with ACPI, there was a large gap between 
ACPI development work and kernel releases.  From my understanding, these 
days, the 2.4 and 2.6 kernels use the same ACPI system, and improvements 
  by the ACPI team show up rather quickly in the kernel, especially the 
2.6 series.  I'm sure others on this list are more qualified to talk 
about this than I am.

Certainly ACPI is a complex system, and transitioning from APM is 
difficult.  These topics are worthy of documentation efforts like yours. 
  However, it may be better to start such a document with "Be sure you 
are using the latest 2.4 or 2.6 kernel", provide a reference to 
documents which may assist users in upgrading their kernel, and focus on 
ACPI configuration and troubleshooting itself.

Regards,
-John


-- 
http:// ift ile.org/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
