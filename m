From: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Subject: Re: Re: New SmartBattery DSDT-based controller
Date: Mon, 31 Jan 2005 06:57:33 -0500
Message-ID: <41FE1D2D.8030006@bartol.udel.edu>
References: <41FBDDE2.1050403@bartol.udel.edu> <m24qgyorl3.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m24qgyorl3.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Johan Vromans wrote:
> Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org> writes:
> 
> 
>>5) Download the modified DSDT, and install it following the
>>instructions at http://forums.gentoo.org/viewtopic.php?t=122145 (see
>>section 9; although in Gentoo forums, these instructions should work
>>on most systems).
> 
> 
> Although appending the DSDT to the initrd is a neat trick, wouldn't it
> be better to have a kernel boot parameter, e.g. "dsdt_override=myDSDT.aml"?

One of the approaches mentioned in the Gentoo forums guide (section 9b, 
IIRC), is almost equivalent to this: within grub, the extra line 
"initrd=myDSDT.aml" is added beneath the kernel line. However, I agree 
that it would be better if this could be done using a kernel parameter; 
I think it is not too unreasonable to expect "normal" users to mess 
around with kernel parameters.

My current thinking of the best way to incorporate the DSDT 
modifications, is to do it via patches. This would avoid the clumsiness 
of having a large on-line database of modified tables, and also 
circumvent any copyright issues.

Thanks to all who have already sent me DSDTs to fix; I'll be publishing 
patches to these tables Real Soon Now. At the moment, I'm 
re-implementing the SMBus control method interface, to replace the 
reference implementation taken from appendix B of the SMBus-CMI 
specification.

cheers,

Rich


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
