From: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Sat, 15 Jan 2005 15:24:22 +0100
Message-ID: <47e0449d050115062420ce03e2@mail.gmail.com>
References: <41E81C2C.8010809@bartol.udel.edu>
	 <1105747983.7368.3.camel@tyrosine>
	 <47e0449d05011419037877f931@mail.gmail.com>
	 <m2fz13x8mw.fsf@phoenix.squirrel.nl>
Reply-To: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m2fz13x8mw.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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
List-Id: linux-acpi@vger.kernel.org

I thought it wouldn't be necessary to apply the patch because Rich
didn't mention it in his README file.

Regards,
Johannes


On Sat, 15 Jan 2005 11:57:11 +0100, Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org> wrote:
> Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> 
> > I had to put
> > EXPORT_SYMBOL(acpi_ec_write); and EXPORT_SYMBOL(acpi_ec_read); after
> > the functions in drivers/acpi/ec.c.
> 
> This is one of the issues Bruno's patch addressed...
> 
> -- Johan
> 
> 
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
