From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: sbs-linux: smart batteries on SourceForge
Date: Mon, 07 Feb 2005 07:06:51 -0500
Message-ID: <420759DB.1000009@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu>	<42057EBE.5090102@bartol.udel.edu> <m23bw8zpdz.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <m23bw8zpdz.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
> 
> 
>>Full instructions are provided in the accompanying README file.
> 
> 
> If I understand the instructions correctly, _every_ change to the BIOS
> settings would require me to:
>  - boot a non-DSDT-overriding kernel
>  - extract the (possibly modified) DSDT
>  - repeat the patch procedure, building a new DSDT
>  - strip the old one from my initrd, and append the new DSDT
>  - reboot the new kernel
> 
> This is quite cumbersome.
> Is there any insight in what changes to BIOS settings would lead to
> changes in the DSDT?
> 
> -- Johan

Things like enabling/disabling mobo devices such as the parallel and 
serial ports; changing the power policies; modifying the IRQ assingment 
stuff.

But how often does one do all this, once one's laptop is properly 
configured?

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
