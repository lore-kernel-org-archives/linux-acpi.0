From: Yu Luming <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux kernel crash in ACPI code
Date: Wed, 28 Sep 2005 15:29:15 +0800
Message-ID: <200509281529.15826.luming.yu@intel.com>
References: <1127505777.13580.55.camel@desktop.igoweb.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1127505777.13580.55.camel-r49W/1Cwd2cZLhczpVEeqB2eb7JE58TQ@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "William M. Shubert" <wms-GS4XM6VRHqgdnm+yROfE0A@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>
> As you can see, it crashes inside the ACPI code, apparently because a
> spinlock is being used before it is initialized. I'm not sure that the
> dump is exactly the same every time, but I have noticed that it always
> includes several "acpi_..." functions in the stack.
>
> The system is a KDS Valiant 6000 laptop, with a pentium III cpu. This
> dump is from kernel 2.6.12-1.1456_FC4, although I have seen it in at
> least two other FC4 kernels.
>
> My apologies if this bug has already been found and fixed, or if this is
> sent to the wrong email address. Let me know if you need any more
> information to help track this down.

Could you try base kernel 2.6.14-rc1 or later?

>
> PS - Len, I think we worked together at intel some years ago. Were you
> ever working in Cornell Oaks in the enterprise servers group?



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
