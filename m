From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/9] PCI: MMCONFIG clean up
Date: Fri, 6 Mar 2015 12:53:02 -0600
Message-ID: <20150306185302.GJ20077@google.com>
References: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:37308 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009AbbCFSxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Mar 2015 13:53:06 -0500
Received: by obcwp4 with SMTP id wp4so15511407obc.4
        for <linux-acpi@vger.kernel.org>; Fri, 06 Mar 2015 10:53:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1425049244-19331-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: wangyijing@huawei.com, arnd@arndb.de, hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, al.stone@linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org

On Fri, Feb 27, 2015 at 04:00:35PM +0100, Tomasz Nowicki wrote:
> MCFG ACPI table and PCI ECAM standard have no arch dependencies so it can be
> used across all architectures. Currently MMCONFIG related code resides in
> arch/x86 directories. This patch set is going to isolate non-architecure
> specific code and make it accessible for all architectures.

Hi Tomasz,

This doesn't apply on v4.0-rc1:

  $ stg import -M --sign m/tn
  Checking for changes in the working directory ... done
  Importing patch "x86-pci-clean-up-comment-about" ... done
  Importing patch "x86-pci-abstract-pci-config" ... done
  Importing patch "x86-pci-reorder-logic-of" ... done
  Importing patch "x86-pci-acpi-move-arch" ... error: patch failed: arch/x86/pci/mmconfig-shared.c:657
  error: arch/x86/pci/mmconfig-shared.c: patch does not apply
  stg import: Diff does not apply cleanly

Can you refresh and repost, please?

Bjorn
