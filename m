From: Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>
Subject: Re: dsdt buggy acpi
Date: Wed, 2 Jul 2008 08:25:55 +0300
Message-ID: <20080702082555.0959ef2b@linux360.ro>
References: <dd18b0c30806302339q7b3effybf8a7f619b009262@mail.gmail.com>
	<200807011619.53339.rjw@sisk.pl>
	<dd18b0c30807010918p48cfbe2bnb7e4a2bf00a01638@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762286AbYGBF0t@vger.kernel.org>
In-Reply-To: <dd18b0c30807010918p48cfbe2bnb7e4a2bf00a01638@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 1 Jul 2008 16:18:45 +0000
"Justin Mattock" <justinmattock@gmail.com> wrote:

> Cool; thanks.
> I'll check that out and see where and how I can locate the dsdt
> manufacture number,  then see if I can fix the broken dsdt error and
> apply this to the kernel and see what happens.
> regards;

Just one note here: DSDTs have nothing to do with the kernel. This is
just broken firmware. The most one can do _in-kernel_ is blacklist some
functionality or create a workaround, but this only happens for widely
used stuff. Broken DSDTs aren't widely used stuff, they are written by
the machine's vendor (the laptop's manufacturer for example, but this
could be different for desktops) and differ a lot from one machine to
another.


	Eduard
