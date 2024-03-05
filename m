Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F66D27E;
	Tue,  5 Mar 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669959; cv=none; b=qbxhjO7hl5vZRa9hm55oMFgtrmjINmc0ycd/8RoK3r6I1cjjGHopCKBIcx7NNP6dIEWfi4X9PW58b+Rr7JPJsjDePd32XMgt9g3+horj48X7sk6i8tktEriWn3d9XXaRYngSZqlQxKh5e/9JJimMZ5SMQeWBYaS077FIa1RtsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669959; c=relaxed/simple;
	bh=nQ6fLtGVbDv1jsxJI65bQJDbl719I1CI6SX6MN/8OZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktqWyytS+DZNW8f3rNfe6XBUXeMIoxXRmWIQGGzTLffJXEspgZBZc9aQEurLFF6G3leT9jKE/Uv5w0YUIFoAyjwm74zPveDYlWfhW5zwBcFoHTtUQHDjUNKtfGKcjS07EEJDeoASUUKYHlv+tW1Fr62P4ne8w9w9goTKqp7Ocig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DjiMzww1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DjiMzww1"
Received: from [100.64.1.74] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F6C820B74C0;
	Tue,  5 Mar 2024 12:19:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F6C820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709669952;
	bh=A7mHUKBlujlqiSWstI8E2zbUA6gQ/Nlqe64JJolnUlo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DjiMzww1rHZYnU7sMhaUFv3Mt56rQFMp2h68jwVR3+SQpO7y9nSRExg9M2xYVfzrr
	 OlYXk5yOab97pqJ9AyhW+dbfVmMlOsyw9Ve20D19WTspFj2yN5NPfZ6+UfJWFD8mNV
	 a1jQP9xu7Oy1zOM3Q6HtBFmFiXtEfhEV/e4JlfNI=
Message-ID: <5cd020bf-35a1-4ffc-bb32-167ac311d5d3@linux.microsoft.com>
Date: Tue, 5 Mar 2024 12:19:11 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acpi: Use access_width over bit_width for system
 memory accesses
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jarred White <jarredwhite@linux.microsoft.com>
Cc: Len Brown <lenb@kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 srivatsabhat@linux.microsoft.com, stable@vger.kernel.org
References: <20240301192600.2568-1-jarredwhite@linux.microsoft.com>
 <CAJZ5v0hTmkB_rrFgxUYbrxbs_JC-vM1oYdH27D-QvVaVuovNXg@mail.gmail.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <CAJZ5v0hTmkB_rrFgxUYbrxbs_JC-vM1oYdH27D-QvVaVuovNXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/2024 12:15 PM, Rafael J. Wysocki wrote:

<snip>
> 
> Applied as 6.9 material with some edits in the subject and changelog
> and some adjustments of the new comments (one edited and one dropped).
> 
> Thanks!

Thank you, Rafael! Could you please add as well:

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Thanks,
Easwar
