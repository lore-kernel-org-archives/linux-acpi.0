From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Mon, 17 Jan 2005 20:36:41 -0500
Message-ID: <41EC6829.1070901@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com> <m2fz13x8mw.fsf@phoenix.squirrel.nl> <41EA2C1D.3030909@bartol.udel.edu> <41EBE769.7050107@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41EBE769.7050107-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pedro Venda wrote:

> The report:
> 
> I've tried to load the module and it still has the mutual-exclusion 
> problem with
> the acpi AC and battery drivers. How can that be fixed?
> 
> With AC built-in the kernel, the module segfaults on insmod...

Not surprised, there's probably all manner of crap that happens when one 
tries to mkdir /proc/acpi/ac_adapter more than once.

But I'm not sure why this is happening with the revised version of the 
code (20050116); this version contains #ifndef directives to prevent the 
legacy interfaces being compiled in if they are already in the kernel. 
Are you sure your kernel configuration matches your currently-running 
kernel?

> After removing the AC driver, it loads fine and reports good results.
> Appearently looks nice. Tried with and without battery. Both SBSEL, SBC 
> and SB0
> values make sense.

Excellent!

> 
> Don't know if it's still relevant, but here's a link for my version of the
> smartbattery.c userspace program. just "make" and test it. needs the 
> i2c-dev and
> i2c-acpi-ec drivers.
> 
> http://arrakis.dhis.org/linux/smartbattery/smartbattery-20050117.tar.gz

Thanks for the pointer, I'll try this out!

cheers,

Rich


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
