From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 06/15] PCI/acpiphp: Convert "acpiphp" sub-driver's
 functionality to built-in only
Date: Thu, 6 Dec 2012 22:48:42 -0800
Message-ID: <CAE9FiQUh_jcoemFpeiAKHr4FyxSA4itHycNwJk+Dhf45Ap5prA@mail.gmail.com>
References: <20121207062454.11051.12739.stgit@amt.stowe>
	<20121207062530.11051.47869.stgit@amt.stowe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43131 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab2LGGso (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Dec 2012 01:48:44 -0500
In-Reply-To: <20121207062530.11051.47869.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 6, 2012 at 10:25 PM, Myron Stowe <myron.stowe@redhat.com> wrote:
> The "ACPI Hot Plug PCI Controller ("acpiphp")" sub-driver may be compiled
> as a module.  Kernel modules are instantiated somewhat randomly - the
> order in which they are linked as the kernel as built - thus if there are
> any dependencies on the ordering of attaching sub-drivers, they can not be
> effectively dealt with.
>
> This patch series resolves any potential sequencing inter-dependencies by
> converting "acpiphp" sub-driver's functionality to being only supported as
> statically built-in to the kernel.  Inter-dependencies can then be
> effectively handled by explicitly sequencing the addition of such
> functionality.

some slots may support both acpiphp and pciehp.

if make acpiphp to be built-in, user do not have choice anymore.

Thanks

Yinghai
