From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 1/11]avoid check _STA method
Date: Wed, 27 Aug 2008 09:53:09 +0200
Message-ID: <20080827075309.GP26610@one.firstfloor.org>
References: <1219806859.32665.57.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:38218 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbYH0Huk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 03:50:40 -0400
Content-Disposition: inline
In-Reply-To: <1219806859.32665.57.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andi Kleen <andi@firstfloor.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Tejun Heo <htejun@gmail.com>

On Wed, Aug 27, 2008 at 11:14:19AM +0800, Shaohua Li wrote:
> =EF=BB=BFIn some BIOSes, every _STA method call will send a notificat=
ion again,
> this cause freeze. And in some BIOSes, it appears _STA should be call=
ed
> after _DCK. This tries to avoid calls _STA, and still keep the device
> present check.
> =EF=BB=BFhttp://bugzilla.kernel.org/show_bug.cgi?id=3D10431

General comment before I review any code. Your mailer adds strange
characters to the comment log: (e.g. in this case before the "In"
and the "http"). My vim displays that as lots of &&&&&? Can you
remove that please?

-Andi
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
