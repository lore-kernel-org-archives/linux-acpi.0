From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Sun, 30 Sep 2012 00:07:49 +0200
Message-ID: <201209300007.49771.rjw@sisk.pl>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <5066C246.1050003@gmail.com> <50673394.5030502@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51753 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab2I2WBN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Sep 2012 18:01:13 -0400
In-Reply-To: <50673394.5030502@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Francesco Lavra <francescolavra.fl@gmail.com>, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Saturday, September 29, 2012, Daniel Lezcano wrote:
> On 09/29/2012 11:41 AM, Francesco Lavra wrote:
> > Hi,
> 
> Hi Francesco,
> 
> thanks for reviewing the patch.
> 
> >>  static ssize_t show_current_driver(struct device *dev,
> >>  				   struct device_attribute *attr,
> >>  				   char *buf)
> >>  {
> >> -	ssize_t ret;
> >> -	struct cpuidle_driver *cpuidle_driver = cpuidle_get_driver();
> >> +	struct cbarg cbarg = { .buf = buf };
> > 
> > cbarg.count should be initialized to 0.
> 
> Actually, with this initialization, all the fields will be initialized
> to 0, except 'buf'.

However, it would be good to initialize count explicitly so as to show
that we care about the initial value of it.

Thanks,
Rafael
