From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Run-time PM idea (was: Re: [linux-pm] [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 08:54:19 +0200
Message-ID: <20090608065419.GA13568@elte.hu>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org> <200906072347.00580.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753742AbZFHGyj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200906072347.00580.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-acpi@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> +config PM_RUNTIME
> +	bool "Run-time PM core functionality"
> +	depends on PM
> +	---help---
> +	  Enable functionality allowing I/O devices to be put into energy-saving
> +	  (low power) states at run time (or autosuspended) after a specified
> +	  period of inactivity and woken up in response to a hardware-generated
> +	  wake-up event or a driver's request.
> +
> +	  Hardware support is generally required for this functionality to work
> +	  and the bus type drivers of the buses the devices are on are
> +	  responsibile for the actual handling of the autosuspend requests and
> +	  wake-up events.

Halleluya! :-)

	Ingo
