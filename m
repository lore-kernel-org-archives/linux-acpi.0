From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: Developing ACPI for Linux - March 27, 2007
Date: Wed, 28 Mar 2007 09:10:28 +0400
Message-ID: <8f8ff01d0703272210h1242875cs5f00a7d29da14fc0@mail.gmail.com>
References: <200703271650.16945.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:5815 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbXC1FK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Mar 2007 01:10:29 -0400
Received: by an-out-0708.google.com with SMTP id b33so2963884ana
        for <linux-acpi@vger.kernel.org>; Tue, 27 Mar 2007 22:10:28 -0700 (PDT)
In-Reply-To: <200703271650.16945.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Len,
We talked about converting ACPICA tree from CVS to git, and didn't
find a reason for that.
I think now it's become interesting again. What if you make snapshot
"git cvsimport" of CVS  ACPICA (Acpi/source) is enough, and make it
available as all other ACPI git trees you have?

It is also possible to modify our conversion scripts to work from this
snapshot, so it will be easy to try modifications on Linux.

Regards,
Alex.
