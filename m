From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH v3]: ACPI: Ignore invalid _PSS entries, but use valid
 ones
Date: Tue, 08 May 2012 01:59:09 -0400
Message-ID: <4FA8B62D.7000102@kernel.org>
References: <CAEe-dwjEM8bHV838VwAO1riQk7tVUgdwKxnULxXzrajqjHkLaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42403 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab2EHF7M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 May 2012 01:59:12 -0400
Received: by qcro28 with SMTP id o28so2453247qcr.19
        for <linux-acpi@vger.kernel.org>; Mon, 07 May 2012 22:59:12 -0700 (PDT)
In-Reply-To: <CAEe-dwjEM8bHV838VwAO1riQk7tVUgdwKxnULxXzrajqjHkLaQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marco Aurelio da Costa <costa@gamic.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-acpi@vger.kernel.org

A BIOS bug workaround like this is sort of a guessing game...

What additional benefit do we get by making the workaround more complicated?

thanks,
-Len

