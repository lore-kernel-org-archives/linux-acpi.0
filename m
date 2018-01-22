From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Re: ACPI: sbshc: remove raw pointer from printk message
Date: Mon, 22 Jan 2018 08:18:53 +0100
Message-ID: <20180122071853.GB15646@kroah.com>
References: <20180119090603.GA7775@kroah.com>
 <CAJZ5v0jh7sUje5RcEJVT_bLM9u=9z0pbPBEWy=4k-tfKfKO-SQ@mail.gmail.com>
 <20180120073613.GB18663@kroah.com>
 <CAJZ5v0htCL_b6+Pn22Ce612MrBJ6D+4Jby58BdXxjSX_zmNjiw@mail.gmail.com>
 <20180120081639.GB21147@kroah.com>
 <2018012211145163626812@venustech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:45102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeAVHSz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jan 2018 02:18:55 -0500
Content-Disposition: inline
In-Reply-To: <2018012211145163626812@venustech.com.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "wang_qize@venustech.com.cn" <wang_qize@venustech.com.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, security <security@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Jan 22, 2018 at 11:19:36AM +0800, wang_qize@venustech.com.cn wrote:
> 
>  I has recvied a cve-id from mitre.org for this security bug .
> should this cve-id( CVE-2018-5750) be mentioned in kernel change log?

Only if Rafael wants to hand-edit the patch, it's not really needed for
a kernel log commit message to have CVE items in it, especially as the
id was received after the patch was created and submitted.

thanks,

greg k-h
