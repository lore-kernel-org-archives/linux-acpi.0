From: Daniel Pekelharing <legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Battery not visible?
Date: Fri, 21 Oct 2005 14:03:50 +0200
Message-ID: <1129896230.2929.3.camel@AMD-2600>
References: <1129835275.5487.8.camel@AMD-2600> <4358BD7A.9000206@qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4358BD7A.9000206-aUOafQfIvX+1Qrn1Bg8BZw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Acpi-Devel-List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-10-21 at 11:05 +0100, Michael Doube wrote:
> Hi Daniel
> 
> The fedora RPM kernel 2.6.13-1526_FC4 works on my Aspire 3023 WLMi, in 
> conjunction with ec_burst=1 kernel option.
> 
> It may well work for you, too.
> 

On Thu, 2005-10-20 at 14:16 -0700, foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
wrote: 
> The usual fix for AE_TIME errors: try booting latest kernel.org 2.6.xx
> kernel with proper configuration for your hardware, and set kernel boot
> option "ec_burst=1".


Thanks guys... I'll give it a try as soon as get time to update my kernel.

-- 
Daniel Pekelharing
<legendstar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
