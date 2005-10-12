From: Mattia Dongili <malattia-k2GhghHVRtY@public.gmane.org>
Subject: Re: Latest acpica
Date: Wed, 12 Oct 2005 23:56:28 +0200
Message-ID: <20051012215628.GG3658@inferi.kami.home>
References: <971FCB6690CD0E4898387DBF7552B90E02AA4005@orsmsx403.amr.corp.intel.com> <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c0a09e5c0510121037l3be5774bj3ec5e0d50449c69f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Oct 12, 2005 at 10:37:59AM -0700, Andrew Grover wrote:
> I am using GNU flex 2.5.31. I was able to get it to build (on x86_64 even)
> with the attached patch. I have also attached the warnings, in case those
> are of interest.
> 
> (Any Debian people want to package iasl?)

I submitted the ITP, but I'm wondering which licence it is supposed to
be. On the Intel site the Linux package is said to be GPLed but
downloaded files (and the www licence agreement) don't report that as
this is the Unix version.

I also gave a shot to the acpisrc tool that moves everything into a
GPLv2 + CodeStyle clean source tree but the generated source doesn't
build.

Could anybody clarify it?

Thanks a lot
-- 
mattia
:wq!


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
