From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 15:31:39 -0500
Message-ID: <41F166AB.1090506@bartol.udel.edu>
References: <41E81C2C.8010809@bartol.udel.edu>	<1105747983.7368.3.camel@tyrosine>	<47e0449d05011419037877f931@mail.gmail.com>	<m2fz13x8mw.fsf@phoenix.squirrel.nl>	<41EA2C1D.3030909@bartol.udel.edu> <41EC7C7D.1070003@bartol.udel.edu>	<41EC9316.80109@bartol.udel.edu> <41EDE2EA.7090404@bartol.udel.edu>	<m2wtu74yzq.fsf@phoenix.squirrel.nl>	<41F01923.1000503@bartol.udel.edu> <m2sm4v4wk7.fsf@phoenix.squirrel.nl> <41F10180.60008@arrakis.dhis.org> <41F1031E.60507@bartol.udel.edu> <41F106C9.5020404@arrakis.dhis.org> <41F11940.5010101@bartol.udel.edu> <41F1631C.1030701@arrakis.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41F1631C.1030701-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Pedro Venda wrote:

<snip>

> | Ah, but there doesn't have to be any loss of capabilities. There are two
> | separate issues here:
> |
> | 1) Implementing the SMBus access through control methods, as described
> | by the API in the SMBus-CM specification (which I'll be trying out very
> | soon)
> |
> | 2) Implementing a control-method wrapper for SBS, so that it can be
> | accessed using the API described in Sec. 10.2 of the ACPI specification.
> |
> | Issue (1) basically removes the need for the i2c_acpi_ec module, and
> | indeed the need to have any i2c or smbus support in the kernel;
> | everything is done through the embedded controller. This is highly
> | desirable.
> |
> | Issue (2) would allow SBS batteries to appear to the kernel as CM
> | batteries, meaning that the stock battery.ko module can be used. This,
> | however, is obviously a backward-compatibility step, and not the way
> | forward; however, it may be a 'clean' interim solution to implementing
> | SBS, in lieu of a yet-to-be-designed library for accessing SBS and CM
> | batteries through a standard interface.
> 
> ahhh, there's a nice explanation. thanks :-)
> 
> so, just to clear things up, solution (1) doesn't need DSDT patching?? 
> that'd be
> excelent "value-for-money". it'd provide access to SBS information 
> without ugly
> acpi-i2c dependencies.
> 

No, both require DSDT patching -- unless there is a way to add objects 
into the ACPI namespace dynamically (anyone got any ideas on this?).

This of course is a big barrier to adoption. But having said that, 
patching a DSDT is no more difficult than patching a kernel. You just 
tweak the source code, compile it, and then add an initrd= argument to 
the kernel boot parameters.

However, maybe someone could do some work on making it even easier? Any 
thoughts?

cheers,

Rich

-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
