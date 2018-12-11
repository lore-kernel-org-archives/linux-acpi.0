From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/3] ACPI / OSL: Allow PCI to be disabled
Date: Tue, 11 Dec 2018 11:07:08 +0100
Message-ID: <CAJZ5v0htmHTgRa9TZ7f0XcGEt_XMmfEYhcQ=N2Lcn1V+TxPzxg@mail.gmail.com>
References: <20181210181315.5023-1-okaya@kernel.org> <20181210181315.5023-2-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181210181315.5023-2-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 10, 2018 at 7:13 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> Getting ready to allow PCI to be disabled with ACPI enabled. Stub
> out calls that depend on PCI.

I would prefer the subject to say something like "Allow CONFIG_PCI to
be unset" or "Allow PCI to be disabled in Kconfig".

It is somewhat ambiguous otherwise and one has to look at the patch to
see what it really is about.
