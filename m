From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] [PATCH][pvops_dom0][2/4] Introduce the external control
 operation interface for domain0 ACPI parser
Date: Thu, 30 Jul 2009 15:04:52 -0700
Message-ID: <4A721904.7040406@goop.org>
References: <4D05DB80B95B23498C72C700BD6C2E0B315D64CC@pdsmsx502.ccr.corp.intel.com> <E87738D94A6AD54789B5B8D1BAEB06CC5C744C68C2@azsmsx503.amr.corp.intel.com> <4D05DB80B95B23498C72C700BD6C2E0B315D671A@pdsmsx502.ccr.corp.intel.com> <alpine.LFD.2.00.0907301204260.17818@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from claw.goop.org ([74.207.240.146]:33882 "EHLO claw.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751828AbZG3WEw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jul 2009 18:04:52 -0400
In-Reply-To: <alpine.LFD.2.00.0907301204260.17818@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Yu, Ke" <ke.yu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Tian, Kevin" <kevin.tian@intel.com>

On 07/30/09 09:29, Len Brown wrote:
> Unclear that the power management partitioning between xen hypervisor
> and dom0 is fully baked.
>
> Uncear (to me) what xen is doing internally with these power management 
> objects, and how that differs from what Linux would do.
>   

Yes.  The key thing is that Xen is the only entity which really knows
about physical CPUs and how they're being used, and so is the only thing
which can correctly apply the chosen policy.  If any particular guest
domain did it, it would only take into account that particular domain's
CPU use, and ignore everyone else (or have the extra complexity of
extracting system-wide usage from Xen then applying that to its own policy).

If I understand correctly, the code currently relies on Linux running
the _PSD method with its AML interpreter, and then feeding the results
to Xen as it doesn't have an AML interpreter.  And putting AML into Xen
would be an all-or-nothing proposition, because the entity which runs
AML maintains a lot of state which can't be separated between Xen and
Linux, and can't be shared.

    J
