From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Cast removal
Date: Wed, 4 Oct 2006 17:28:04 -0700
Message-ID: <20061004172804.1704225e.akpm@osdl.org>
References: <B28E9812BAF6E2498B7EC5C427F293A40111D341@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:1992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751253AbWJEA2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Oct 2006 20:28:10 -0400
In-Reply-To: <B28E9812BAF6E2498B7EC5C427F293A40111D341@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, ACPI List <linux-acpi@vger.kernel.org>

On Wed, 4 Oct 2006 14:40:56 -0700
"Moore, Robert" <robert.moore@intel.com> wrote:

> Most of the casting stuff is because ACPICA has to support a bunch of
> different compilers.

What compiler generates a warning when you fail to cast a void*?  That's
standard C isn't it?
