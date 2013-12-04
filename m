From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCHv2 1/2] New Driver for IOSF-SB MBI access on Intel SOCs
Date: Tue, 03 Dec 2013 22:44:18 -0800
Message-ID: <877gblcdz1.fsf@tassilo.jf.intel.com>
References: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
	<1386115178-7559-1-git-send-email-david.e.box@linux.intel.com>
	<1386115178-7559-2-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1386115178-7559-2-git-send-email-david.e.box@linux.intel.com>
	(David E. Box's message of "Tue, 3 Dec 2013 15:59:37 -0800")
Sender: platform-driver-x86-owner@vger.kernel.org
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: mjg59@srcf.ucam.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

"David E. Box" <david.e.box@linux.intel.com> writes:
>  
> +config X86_IOSF_MBI
> +	tristate "IOSF-SB MailBox Interface access support for Intel
> SOCs"

This is only implicitly used by other drivers, right?

Please make it not user visible (drop the string after tristate), as users 
will not know when to enable it.

The other drivers using it should always select it instead.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
