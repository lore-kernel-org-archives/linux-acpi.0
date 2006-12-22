From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: ACPI C-State configuration question.
Date: Fri, 22 Dec 2006 15:02:18 -0500
Message-ID: <458C39CA.5000208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:65386 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbWLVUCV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Dec 2006 15:02:21 -0500
Received: by wx-out-0506.google.com with SMTP id h27so2824322wxd
        for <linux-acpi@vger.kernel.org>; Fri, 22 Dec 2006 12:02:21 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Can someone tell me if there is a way to influence how frequently or how 
often a processor jumps between C-States?
Specifically, it seems like my processor changes a whole lot, and I'd 
like to try to encourage it to change less frequently, and stay in the 
lower power states longer.

If anyone knows, could you give me a few pointers? Or perhaps point me 
at some documentation? I haven't been able to find much about this 
specific type of need.

Thanks,
Lincoln
