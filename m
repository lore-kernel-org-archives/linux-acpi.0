From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / utils: remove redundant check if element is NULL
Date: Fri, 11 Mar 2016 00:34:56 +0100
Message-ID: <6080101.Xh3F3pdZMM@vostro.rjw.lan>
References: <1456691509-7855-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456691509-7855-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sunday, February 28, 2016 08:31:49 PM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> element is &package->package.elements[i] which can never be NULL
> so the check to see if it is NULL is redundant and can be removed.
> 
> Detected with static analysis by CoverityScan
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!

Rafael
