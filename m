From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: New SmartBattery DSDT-based controller
Date: Mon, 31 Jan 2005 17:54:56 +0100
Message-ID: <20050131165456.GF1145@poupinou.org>
References: <41FBDDE2.1050403@bartol.udel.edu> <20050131151235.GB1145@poupinou.org> <41FE5E29.9020308@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41FE5E29.9020308-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 31, 2005 at 11:34:49AM -0500, Rich Townsend wrote:
> >I don't see the point of making this if this is only for
> >smartbatt.  Do you have to override the DSDT for something else
> >(and then, well, why not)?
> 
> Maybe sometimes things are better done by fixing the DSDT, rather than 
> adding more bloat into the kernel. And I use the word 'fixing' 
> carefully; many modern laptops use smart batteries, but expose these 
> batteries to the OS via the tradition Control Method (CM) interface. In 
> that sence, Acer's DSDTs are broken, because they lack the necessary CM 
> wrapper for the smart battery system (SBS).
> 
> There's certainly a case to be made that smart batteries should be dealt 
> with natively in the kernel, since an SBS has many more data than a CM 
> interface can expose. However, there are a number of design questions 
> that need to be addressed before this issue can be tackled in a proper 
> manner (I consider my acpi-sbs module to be little more than a 
> proof-of-concept). In particular,
> 
> *) Others have pointed out that a unified kernel API for batteries & 
> power sources is required, to hide the messy CM vs. SBS details away. 
> What should this API do? Will it provide /proc entries? How will it keep 
> backward compatibility with all of those applications that look in 
> /proc/acpi/battery/*

This is part of long goal indeed.

> *) How should we deal with systems that present a CM interface in their 
> DSDT, but are internally implemented using SBS? Should the DSDT 
> interface be bypassed, to expose the full SBS data?

Yes and no.  The kernel really need only a few (especially gauge stuff).
The rest should be done in userspace IMHO.

> *) With SBS being accessed via the SMBus, how do we deal with the 
> messyness of having ACPI-related code depend on I2C code? Should the 
> SMBus access be performed totally independent of the rest of the kernel 
> I2C framework?
>
> Just some thoughts...
> 
> On a final note: yes, I know the DSDT hacking solution seems awful to 
> those who would rather do it all in the kernel. However, my viewpoint is 
> this: I had an itch to scratch. I have scratched it. Others can scratch 
> too. Don't sweat over the elegance of the scratching, it will all come 
> out OK in the end...

Just that I don't see why you don't want your own acpi-sbs stuff,
with some kind of compatibility with existing acpi/ac /proc interface.
Thats this exact point I don't see the light yet.  I don't have the
hardware to play with, btw.  Just... well, maybe I will see the light
soon.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
