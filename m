From: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hotplug
Date: Mon, 17 Jan 2005 15:48:01 -0800
Message-ID: <20050117154801.A22139@unix-os.sc.intel.com>
References: <20050117140121.A21143@unix-os.sc.intel.com> <20050117221751.49612.qmail@web50204.mail.yahoo.com>
Reply-To: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050117221751.49612.qmail-zX69vREatC6A/QwVtaZbd3CJp6faPEW9@public.gmane.org>; from i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org on Mon, Jan 17, 2005 at 02:17:51PM -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paul Ionescu <i_p_a_u_l-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: Rajesh Shah <rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 17, 2005 at 02:17:51PM -0800, Paul Ionescu wrote:
> 
> I do have an IBM Thinkpad, and I am using IBM_ACPI
> module. But this module is limited in functionality

OK.

> If I boot docked in, I have more ACPI devices than if
> I boot undocked, and that info is not possible for
> ACPI to get dynamically when I plug the laptop in

I see. Can you please send the dmesg output after enabling
debug messages in acpiphp (acpiphp supports a "debug"
module param)?  I'd like to see if acpiphp is even 
installing a notify handler and triggering at dock.

Also, can you send the lspci -vv output with the 
laptop docked at boot time? 

Thanks,
Rajesh



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
