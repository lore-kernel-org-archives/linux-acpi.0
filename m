From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1 00/13] PCI: Device configuration cleanup
Date: Fri, 12 Sep 2014 11:53:14 -0700
Message-ID: <CA+55aFzrt7PRbNbcDJzK2doEuhuvDrNDr=X21m6k0+bXk2tmmg@mail.gmail.com>
References: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:43844 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaILSxP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Sep 2014 14:53:15 -0400
In-Reply-To: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Rajat Jain <rajatxjain@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>

On Fri, Sep 12, 2014 at 11:02 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> Finally, it tweaks several _HPP/_HPX things where we do things not
> required by the spec and I haven't seen any other good reason for them:

Looks ok to me, although, as always, resource management changes just
makes me worry that things worked "by mistake" before.

          Linus
