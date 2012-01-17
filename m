From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] acpi/apei/einj: Add extensions to EINJ from rev 5.0 of
 acpi spec
Date: Tue, 17 Jan 2012 08:05:55 -0500
Message-ID: <4F157233.2010503@kernel.org>
References: <212c4cabb390880e855be9509e7d2be002699907.1325716284.git.tony.luck@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <212c4cabb390880e855be9509e7d2be002699907.1325716284.git.tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ying.huang@intel.com, Chen Gong <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

this patch doesn't build in 32-bit mode:

drivers/acpi/apei/einj.c:256:3: error: implicit declaration of function=
 =91readq=92 [-Werror=3Dimplicit-function-declaration]
