From: Alessandro Guido <alessandro.guido@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Date: Sat, 30 Sep 2006 19:14:57 +0200
Message-ID: <20060930191457.a120ff56.alessandro.guido@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:39747 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751301AbWI3RMf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 Sep 2006 13:12:35 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1211885nfa
        for <linux-acpi@vger.kernel.org>; Sat, 30 Sep 2006 10:12:34 -0700 (PDT)
In-Reply-To: <20060930190810.30b8737f.alessandro.guido@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr

On Sat, 30 Sep 2006 19:08:10 +0200
Alessandro Guido <alessandro.guido@gmail.com> wrote:

> Make the sony_acpi use the backlight subsystem to adjust brightness value
> instead of using the /proc/sony/brightness file.
> (Other settings will still have a /proc/sony/... entry)

I meant /proc/acpi/sony/brightness and /proc/acpi/sony/...

sorry
