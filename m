From: Andreas Dieling <snow-1pFVYSAoaJAREI5ypv3d1g@public.gmane.org>
Subject: Re: Resources on fixing DSDT?
Date: Mon, 13 Sep 2004 14:39:18 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <414594F6.7020507@quantentunnel.de>
References: <loom.20040913T141300-570@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <loom.20040913T141300-570-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Tuttle <gmane.thinkinginbinary-w1QkCcy0X+Ct7aBEGUsviw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Thomas Tuttle wrote:

>I have an Asus M2400Ne with a screwed-up DSDT (some of the methods are renamed 
>to proprietary names--A*** instead of _***--for Asus' proprietary power 
>management stuff) and I have had no luck getting SpeedStep to work on it.  
>(Everything else works!)  What I need to do is find the methods in the DSDT 
>that are mis-named, re-name them, and patch my kernel to use the custom DSDT.
>  
>
Isn't the M24N Centrino based? So i think you don't need bios support to 
get your throttling working... intel enhanced speedstep should be enough...

Andreas


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
