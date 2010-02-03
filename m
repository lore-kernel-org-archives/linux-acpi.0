From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: [PATCH] drivers/acpi/ec.c fix a small memory leak
Date: Wed, 03 Feb 2010 12:06:57 +0100
Message-ID: <1265195217.2755.55.camel@localhost>
References: <1265112730.4804.8.camel@ICE-BOX>  <4B684650.9070807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B684650.9070807@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Darren Jenkins <darrenrjenkins@gmail.com>, Kernel Janitors <kernel-janitors@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Die, 2010-02-02 at 18:35 +0300, Alexey Starikovskiy wrote:
> NAK
> 
> saved_ec is allocated if flag EC_FLAGS_VALIDATE_ECDT is true.
> EC_FLAGS_SKIP_DSDT_SCAN have no sense in such case, thus this new code path
> is never executed.
> On the other hand, unconditionally freeing pointer, which is might be NULL, is not
> right either.
Why that?
"kfree(NULL);" works (and in the user-space "free(NULL)" too FWIW).

> So, this patch introduced more problems as it tries to solve...

	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
