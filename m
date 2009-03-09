From: pyther <pyther@pyther.net>
Subject: Re: [Bugme-new] [Bug 12831] New: Hot/Fn Keys do not work EEEPC 1000HE
 =?UTF-8?Q?=28eeepc=5Flaptop=29?=
Date: Mon, 09 Mar 2009 17:13:35 -0400
Message-ID: <97114617c7f752b813c4d456188db6ee@localhost>
References: <bug-12831-10286@http.bugzilla.kernel.org/> <20090309125142.54f707dd.akpm@linux-foundation.org> <94855ae5f6d072e7c9b5920b67fc4c1d@localhost> <20090309203722.GA18521@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.248]:25887 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbZCIVNk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Mar 2009 17:13:40 -0400
Received: by ag-out-0708.google.com with SMTP id 26so3501635agb.10
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2009 14:13:38 -0700 (PDT)
In-Reply-To: <20090309203722.GA18521@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Corentin Chary <corentincj@iksaif.net>, bugme-daemon@bugzilla.kernel.org, patrick.bregman@gmail.com, linux-acpi@vger.kernel.org


I can do that, however how would I go about narrowing it down to a smaller
range of patches? Would I simply apply patches from
(http://kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fpatch-2.6.29-rc7.bz2)
to the 2.6.28 source and compile until I find the one that breaks the hot
key functionality?


