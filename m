From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.5.50, ACPI] link error
Date: Thu, 05 Dec 2002 19:36:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <3DEFF11D.9060206@pobox.com>
References: <20021205224019.GH7396@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0212051632120.974-100000@localhost.localdomain> <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021206000618.GB15784@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Pavel Machek wrote:
> S3 needs process stopper from kernel/suspend.c. I did not want to have
> #ifdefs all over suspend.c...


Then move it to a different file, that may be shared between various 
CONFIG_xxx features.
