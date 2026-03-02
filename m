Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD30469D
	for <linux-acpi@vger.kernel.org>; Mon,  2 Mar 2026 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772409692; cv=none; b=Rt5+zRsHD5UQu9SKdaflPsAJWK1tKi+mq66MzMZbKLIfGwA8v2zCg6Gs8WNGd+MgRq7nqUGa7VzSIq4GdSJqxJiQGW10ySVAIQK7fnsEUagPnXl9WfHw7+X7bj4nFPHxIIZ5xU8gJCOO/gytwKwTzrFYJ2V8BGcoywZ5XZKIRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772409692; c=relaxed/simple;
	bh=eFZMfr+s0Q1UNOMfLG3ds5RmyUtjt747TkosvoFWIWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEBYsp8k+qbj+rn5P+EtCprkf1UFzMymWgWgSYhWhRGdP03C8Ik8fCDQpqUgFVrDhvKvnuzej7aYJL1AvF1BUn2EjwDHSFf8MmDBJSXPr7OmPq5sx/bqAt/QuHUkikd7r36fd8btosKWa4l8BoqG9T0mcXyxf6dIyd4DC4M7O+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIJUHd55; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIJUHd55"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12758ce1e8dso3619768c88.0
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2026 16:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772409690; x=1773014490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfArcU3dsTEXyfI4YzrqdiJ40D8RtnJz+9pcEe41QRs=;
        b=IIJUHd55Sb3qO1XdCzysM72J+evfQl5CkODxAisZ3I5WOUarunsVF0+FNZ9qjNDbRA
         Yr0eF6UaR47713K+6OxejLdPtj6xlLVcIp9sMym88yHWKPJHLgPoXYuotBvleRMljAqL
         /b9r5jojct+82qhcw33gbJ33hYGfyrEiLpir6qrRdcvb67NJRQgpHlSn3fX6CrAUTllH
         HKSviWCgNhpA1Y8TjldwMpMKvAWARRhYaLnA2U2htvHMYeBAIXxNlbZT+rAyxGC+HllR
         INXY6GJfvRLOkCAw2nBgJgwRHOmNqfZXTJAvRgt0mPtfGE2yss8nvmKTQn8eMWAtmw/y
         sTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772409690; x=1773014490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OfArcU3dsTEXyfI4YzrqdiJ40D8RtnJz+9pcEe41QRs=;
        b=qg4MHtwbp0ei5f02UtXvr0Co8qMLsvGN2fiqVrcjLCR04b7k0x/iHftfE+Yd5yoZID
         NjVtzI2RZbEkzu1aijM/JPMZ0TGJ7zGc1z6S2U+VGOMol1A1XK4QcfCMwLjjsxTHgib2
         MHZ6qWEfdF9Q0Krep8W4AknhEWl4nZqTAClXZ1CjFELFTKipUbkT5/9aGbT8z6UoveIj
         R4a6y6qMxt/rLPi0gr6ThCrjOtoYcXqkS+H7Yt3IfhpFB2tvNrqN2Jq6XX4cKyU5jRQz
         mUWQ3cjVb5nJEHM9hOr09ErYUt1HhrQZxtNzSakm/pdh2sIFJX8RaObUgB46XDuUcXSJ
         CYTg==
X-Forwarded-Encrypted: i=1; AJvYcCW1+XWBwQiuSRdZyIKTJX4iDMUR6fgc+dLVh0xKZ5FMAxN28u2QSlU/7RQMQh1RIJvbqR8ijMGUPVkg@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcGtDiPaeujJW+HkR+UPuw/djuWle6G1298fNXJ+3yb/x35j8
	qCu/KO6/0R5TnNvyv/P66jANLIaY7R/BfxdXxlSLC4cEZ8uwNMGbAUwl
X-Gm-Gg: ATEYQzy30rPSQRZqfWblDhgSfiWcRFO/IAldCM6wmUHhw9s9XqJ4XtJIaFyG8m2TowB
	EkeEZqJODlxzJQnJNUUUMOZysgjdWEcGiFzhBN7EKwns2h7fMVqL2YRIwk/VEy9i37fek1jcgQy
	Kv8LMKvFdFr6WV6LTweJ+0vjfw5tjRwFv7xBP6InfFmWIDnWHhLwwhyxrsxBGADD2rIuL+XdfL6
	wrMJVlvwD3nQxMWawe6rbd3if+sPoMFQGgKb7pVzofEFF8iC6gfdwr3EN03Y7XPL1FtEIcbs+fv
	T/64rPudg1QbslaM72HVlEGhH9M3EovDdPIb+sNd4bP0U5GSEniB13pfDFVT+u6JBKIq8fQ4jwi
	YcWvuZRSZRQhC6/TiYAYwEhNE1PpFjxnuGWNK0CfZIgVc7vzO/3ld4VqnZw/z26U1Ql3Z5y94rm
	My8FwDLPAB2ZKNwARxEAwEK2cSqAF2B9XDvYk7
X-Received: by 2002:a05:7301:1e96:b0:2ae:5ffa:8da4 with SMTP id 5a478bee46e88-2bde1bbf780mr4542339eec.1.1772409689898;
        Sun, 01 Mar 2026 16:01:29 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1731b6b6sm94244eec.5.2026.03.01.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:01:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 1 Mar 2026 16:01:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v1 3/3] hwmon: (acpi_power_meter) Convert ACPI driver to
 a platform one
Message-ID: <b93aae74-6b66-4597-9eda-71e2363f7bba@roeck-us.net>
References: <5974797.DvuYhMxLoT@rafael.j.wysocki>
 <1952740.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1952740.tdWV9SEqCh@rafael.j.wysocki>

On Sun, Mar 01, 2026 at 02:18:49PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the hwmon ACPI power meter driver to a
> platform one.
> 
> After this change, the subordinate hwmon device will be registered
> under the platform device representing the ACPI power meter, sysfs
> notifications will trigger on that device, and diagnostic messages
> will be printed relative to it instead of its ACPI companion.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks a lot for this cleanup work.

I decided to apply the entire series right away to hopefully get some test
feedback before the next commit window.

Thanks,
Guenter
