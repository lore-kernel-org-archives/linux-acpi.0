From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 0/6] PNP: minor cleanups
Date: Fri, 24 Aug 2007 00:52:14 -0400
Message-ID: <200708240052.14542.lenb@kernel.org>
References: <20070815163207.062263984@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59988 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbXHXEwu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 00:52:50 -0400
In-Reply-To: <20070815163207.062263984@ldl.fc.hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>, Adam Belay <ambx1@neo.rr.com>, linux-acpi@vger.kernel.org

On Wednesday 15 August 2007 12:32, Bjorn Helgaas wrote:
> Fix a few more Lindent things and remove some unused code and
> unnecessary casts.
> 
> The last patch removes some null pointer checks in cases where
> I think it's better to just oops immediately rather than return
> an error.

These look fine to me.
Unless somebody objects, I'll send them up via my tree.

thanks,
-Len
