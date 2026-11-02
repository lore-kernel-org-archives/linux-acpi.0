Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657471;
	b=s82CSoZa9J+8zXu3BymFC+VdAFi9KSJIUm0drny7Acq10/duIN15OtJbsYQALTYIbKtq
	 2/i9JMnHpf1H06Pco+VEb9bTycRkKlLOitG7kxz8EY17VeOrn2YAoRdTvxRdskfg5+ENJ
	 fWlGEUXKbi+DvlwSO8JesRpyo6HsuzKLJDAr/L5F5Qccnh6jXXztmR6ncXWZf0OGwF7vM
	 GIh1Qz+vHM8OfKl0lMQ9w+996CFbOzJ2dFhxtQ6cPAyzQympxJbwuMH3ixysEvG8eRIiX
	 6e9Y3C5TtCLhJBiP7huO7Qd3o6S4oj1uD6dGIav6GkiPQelcxKcpnfMwmthAgqd8zLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-Patch-Reply:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=e32Jv6OMDQacI9jPsThqVE/mXf3/ercHeftE9RCjEf8=;
	b=cNG1auofEA0qifcINz7vkjriUmvwtl9JoSIXRS8QZSTSVFxygUOZKur7AU3uTn8tmOLU
	 cADtQ7K9/nBakLl5nlaUBaPriI3b3Kd4npUOKk/Ca9njSznHLlcik7qtwwLDngLm9Mrdr
	 rJysVrd11BG5CAAjLcte9VO7TvEY7rc1ifl6XIWP54G8nC5TyDtWquKvIgN7R7H/7lTie
	 p7FvDfx507rxWOJdBxiuabmz/ro5o/LoAHbUsUWaBBSY69SpueIJOhyEXdglzHGTtFVE2
	 UcihH7mA4MFThEmJyFK6HYXw5TheyAT+0v053rsL9DTnIZY0Q0UdMaoMDYpeOaeTFjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP50mL5M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC3606A326;
	Mon,  2 Nov 2026 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BP50mL5M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DF1F00A16;
	Mon,  2 Nov 2026 22:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793657469;
	bh=e32Jv6OMDQacI9jPsThqVE/mXf3/ercHeftE9RCjEf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BP50mL5MzYIAP8MKKb3se8x9Evd2NDvgf/5BOzKLWDZaAcv9IrG1bJwahktyPmmcj
	 MdPXGCoSFO1f7mi36/7txPLe/50Ecv6xUOoKqMp+j6p7al6Ag41aa80WpV5pJUmdf0
	 W/ovBKgARJiEtLKf0xxDKVdM/yHNn8CaXqePUS1M9mobWWxVYLYnLM7Iyt+Hvnm40+
	 87RWtPIC0J1BOZxS+PU3k34gzH+rm89ZNu7umBcJ13f7wZEMi4nrb5uMoT2DePgy3y
	 cSz+RXRzH8z1KvwbfZqWNPYORiLi291+Mjx76r+RjsXPiBtgeQZSEEwZ/Pe6neTvhs
	 HYukF9DRoO2tg==
From: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] driver core: platform: fix sw node use-after-free on device release
Date: Mon,  2 Nov 2026 23:11:03 +0100
Message-ID: <20261102221103.3356593-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102111420.1330760-1-johan@kernel.org>
References: <20261102111420.1330760-1-johan@kernel.org>
X-Patch-Reply: applied
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon,  2 Nov 2026 12:14:18 +0100, Johan Hovold wrote:
> [PATCH 0/2] driver core: platform: fix sw node use-after-free on device release

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/2] driver core: platform: fix sw node use-after-free on device release
      commit: c4cd09d29529

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
